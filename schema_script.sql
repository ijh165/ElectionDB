CREATE TABLE Province (
	provinceName VARCHAR(255),
	provincePopulation INTEGER,
	provinceGDP REAL, 
	PRIMARY KEY(provinceName)
)
GO

CREATE TABLE Riding (
	ridingName VARCHAR(255),
	ridingPopulation INTEGER,
	provinceName VARCHAR(255),
	PRIMARY KEY(ridingName),
	FOREIGN KEY(provinceName) REFERENCES Province ON DELETE NO ACTION ON UPDATE NO ACTION
)
GO

CREATE TABLE Party (
	partyID VARCHAR(255),
	partyName VARCHAR(255),
	leaderFirstName VARCHAR(255) NOT NULL,
	leaderLastName VARCHAR(255) NOT NULL,
	partyWeb VARCHAR(255),
	PRIMARY KEY(partyID),
	--UNIQUE(partyWeb)
)
GO

CREATE TABLE Ballots (
	ridingName VARCHAR(255),
	candidateFirstName VARCHAR(255),
	candidateLastName VARCHAR(255),
	partyID VARCHAR(255) NOT NULL,
	votes INTEGER NOT NULL,
	PRIMARY KEY(ridingName, candidateFirstName, candidateLastName),
	FOREIGN KEY(ridingName) REFERENCES Riding ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY(partyID) REFERENCES Party ON DELETE NO ACTION ON UPDATE CASCADE,
	UNIQUE(candidateFirstName, candidateLastName, partyID),
	CONSTRAINT voteConstr CHECK(votes>=0),
)
GO

CREATE VIEW Riding_Votes_Summary
AS 
SELECT B.ridingName, B.candidateFirstName AS mpFirstName, B.candidateLastName AS mpLastName, P.partyName AS mpParty, X.mpVotes, X.totalVotes
FROM Ballots B, Party P,
	(SELECT ridingName, MAX(votes) AS mpVotes, SUM(votes) AS totalVotes
	FROM Ballots
	GROUP BY ridingName) X
WHERE B.ridingName=X.ridingName AND B.partyID=P.partyID AND B.votes=X.mpVotes
GO

CREATE TRIGGER TR_SumVotesViolation
ON Ballots
AFTER INSERT, UPDATE
AS IF EXISTS(SELECT R.ridingName
			FROM (SELECT ridingName, SUM(votes) AS sum_votes
				FROM Ballots
				GROUP BY ridingName) S, Riding R
			WHERE S.ridingName=R.ridingName AND S.sum_votes>=R.ridingPopulation)
BEGIN
	ROLLBACK TRANSACTION
	RAISERROR('Error: sum of votes >= riding population',16,1)
END
GO

CREATE UNIQUE NONCLUSTERED INDEX idx_partyWeb_notnull
ON Party(partyWeb)
WHERE partyWeb IS NOT NULL
GO