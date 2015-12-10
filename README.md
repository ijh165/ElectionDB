# ElectionDB
By Ivan Jonathan Hoo

# Description
Final assignment for CMPT354 at SFU.

This assignment consist of creating a database used to store data relating to the 2015 federal election (by creating tables, views, constraints, etc), as well as inserting the "cleaned" data into the appropriate tables. However the data provided is "unclean" and has to be edited so that it can be properly inserted into the database without errors).

# Table Schema
Province = {**provinceName**, provincePopulation, provinceGDP}
Riding = {**ridingName**, ridingPopulation, provinceName<sup>Province</sup>}
Party = {**partyID**, partyName, leaderFirstName, leaderLastName, partyWeb}
Ballots = {**ridingName**<sup>Riding</sup>, **candidateFirstName**, **candidateLastName**, partyID<sup>Party</sup>,  votes}
