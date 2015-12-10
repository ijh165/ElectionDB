# ElectionDB
By Ivan Jonathan Hoo

# Description
Final assignment for CMPT354 at SFU.

This assignment consist of creating a database used to store data relating to the 2015 federal election (by creating tables, views, constraints, etc), as well as inserting the "cleaned" data into the appropriate tables. However the data provided is "unclean" and has to be edited so that it can be properly inserted into the database without errors).

# Table Schema
- Province = {**provinceName**, provincePopulation, provinceGDP}
- Riding = {**ridingName**, ridingPopulation, provinceName<sup>Province</sup>}
- Party = {**partyID**, partyName, leaderFirstName, leaderLastName, partyWeb}
- Ballots = {**ridingName**<sup>Riding</sup>, **candidateFirstName**, **candidateLastName**, partyID<sup>Party</sup>,  votes}

**Note: attributes in bold are primary key, attributes with superscripts are foreign keys referencing the superscripted table

# Constraints
Foreign Key Constraints:
- provinceName in Riding: do not allow deletion or update of referenced attributes
- ridingName in Ballots: do not allow deletion of referenced attributes, cascade changes to referenced attributes
- partyID in Ballots: do not allow deletion of referenced attributes, cascade changes to referenced attributes
 
In addition to the foreign key and primary key constraints there are the following constraints:
- The attribute set {candidateFirstName, candidateLastName, partyID} should be specified as a candidate key in the Ballots table
- The  partyID attribute in Ballots should not be null
- The  partyWeb attribute should be specified as a candidate key in the Party table
- The leaderFirstName and leaderLastName attributes in the Party table should not be null
- The votes attribute in the Ballots table should not be null, and should be greater or equal to zero
- The sum of the votes for a riding should be less than the population of that riding

# View
Additionally there is a view that summarizes data about votes in a riding. The view contains the following columns:
- ridingName
- mpFirstName (the first name of the candidate with the most votes in the riding)
- mpLastName (the last name of the candidate with the most votes in the riding)
- mpParty (the party name of the candidate with the most votes in the riding)
- mpVotes (the votes cast for the candidate with the most votes in the riding)
- totalVotes (the total number of votes cast in the riding)
