# Election Database
By Ivan Jonathan Hoo (ihoo@sfu.ca)

# Description
Final assignment for CMPT354 at SFU.

This assignment consist of creating a database used to store data relating to the 2015 federal election (by creating tables, views, constraints, etc), as well as inserting data into the appropriate tables. However the data provided is "unclean" and has to be edited, mainly to fix UTF-8 character encoding problems (particularly for french letters), before it can be properly inserted into the database without errors.

# Database Schema
**_Table Schema_**:
- Province = {**_provinceName_**, _provincePopulation_, _provinceGDP_}
- Riding = {**_ridingName_**, _ridingPopulation_, _provinceName_<sup>Province</sup>}
- Party = {**_partyID_**, _partyName_, _leaderFirstName_, _leaderLastName_, _partyWeb_}
- Ballots = {**_ridingName_**<sup>Riding</sup>, **_candidateFirstName_**, **_candidateLastName_**, _partyID_<sup>Party</sup>, _votes_}

**Note: attributes in bold are primary key, attributes with superscripts are foreign keys referencing the superscripted table

**_Attributes_**:  
<br/>The attributes are briefly described below where necessary:
- *partyID* - the short party name used to identify the party, e.g. NDP, LIB, etc.
- *partyName* - the full party name
- *leaderFirstName*, *leaderLastName* - the name of the party leader
- *partyWeb* - the party website address
- *votes* - the number of votes cast for the candidate

**_Attribute Domains_**:  
- *provincePopulation*, *ridingpopulation*, *votes* are **INTEGER**
- *provinceGDP* is **REAL**
- The rest of the attributes are in **VARCHAR**(255)

# Constraints
**_Foreign Key Constraints_**:
- provinceName in Riding: do not allow deletion or update of referenced attributes.
- ridingName in Ballots: do not allow deletion of referenced attributes, cascade changes to referenced attributes.
- partyID in Ballots: do not allow deletion of referenced attributes, cascade changes to referenced attributes.
 
**_In addition to the foreign key and primary key constraints there are the following constraints_**:
- The attribute set {*candidateFirstName*, *candidateLastName*, *partyID*} should be specified as a candidate key in the Ballots table.
- The *partyID* attribute in Ballots should not be null.
- The *partyWeb* attribute should be specified as a candidate key in the Party table.
- The *leaderFirstName* and leaderLastName attributes in the Party table should not be null.
- The *votes* attribute in the Ballots table should not be null, and should be greater than or equal to zero.
- The sum of the votes for a riding should be less than the population of that riding.

# View
Additionally the **Riding_Votes_Summary** view summarizes data about votes in a riding. The view contains the following columns:
- *ridingName*
- *mpFirstName* (the first name of the candidate with the most votes in the riding)
- *mpLastName* (the last name of the candidate with the most votes in the riding)
- *mpParty* (the party name of the candidate with the most votes in the riding)
- *mpVotes* (the votes cast for the candidate with the most votes in the riding)
- *totalVotes* (the total number of votes cast in the riding)

# Files
- The file *schema_script.sql* creates all the above tables, constraints (and required triggers), and views
- The *clean_data* folder contains all the "cleaned" data (where the UTF-8 character encoding problems are fixed)
- Data in *party.xlsx* and *independent_party.xlsx* should be inserted into Party table
- Data in *province.xlsx* should be inserted into the Province table
- Data in *riding.xlsx* should be inserted into the Riding table
- Data in *ballots.xlsx* should be inserted into the Ballots table
- When inserting data, the order the data are inserted into the tables should be Party->Province->Riding->Ballots (due to foreign key constraints)
