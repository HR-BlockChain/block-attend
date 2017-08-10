pragma solidity ^0.4.10;

contract Attendance {

    // Stats for all Events
    uint public totalEvents;
    uint public totalAttendees;
    uint public totalActualAttendees;
    
    mapping (string => Event) events;

    struct Event {
        string eventLocation;
        uint eventDate;
        uint eventCreationDate;
        address createdBy;
        uint contributionAmount;
        uint contributionPool;
        uint totalAttendees;
        address[] attendees;
        address[] actualAttendees;
        uint actualTotalAttendees;
    }

    function createEvent(string eventName, string eventLocation, uint eventDate ) payable {
        
        events[eventName].eventLocation = eventLocation;
        events[eventName].eventDate = eventDate;
        events[eventName].eventCreationDate = now;
        events[eventName].createdBy = msg.sender;
        events[eventName].contributionAmount = msg.value;
        events[eventName].contributionPool = msg.value;
        events[eventName].totalAttendees = 1;
        events[eventName].attendees.push(msg.sender);

        totalEvents = totalEvents + 1;
        totalAttendees = totalAttendees + 1;

    }

    function joinEvent(string eventName) payable {

        var currentEvent = events[eventName];

        if (currentEvent.contributionAmount != msg.value) revert();

        currentEvent.attendees.push(msg.sender);
        currentEvent.totalAttendees = currentEvent.totalAttendees + 1;
        currentEvent.contributionPool = currentEvent.contributionPool + msg.value;

        totalAttendees = totalAttendees + 1;
    }

    // Current User must mark Event as attended . Trust System

    function markAttended(string eventName) {
        // Set up GPS tracker

        var currentEvent = events[eventName];

        currentEvent.actualAttendees.push(msg.sender);
        currentEvent.actualTotalAttendees = currentEvent.actualTotalAttendees + 1;

        totalActualAttendees = totalActualAttendees + 1;
    }

    // payout after 24hrs after event;
    // more attendees, more gas used
    
    function payOut (string eventName) payable {

        var currentEvent = events[eventName];

        if (currentEvent.eventDate < now + 24 hours) revert();

        var payout = currentEvent.contributionPool / currentEvent.actualTotalAttendees;

        for (uint i = 0; i < currentEvent.actualTotalAttendees; i++){
            currentEvent.actualAttendees[i].transfer(payout);
        }

    }

     function viewEvent(string eventName) constant returns(string, uint, uint, address, uint, uint, uint, address[], address[], uint){
       var currentEvent = events[eventName];
        return (currentEvent.eventLocation, currentEvent.eventDate, currentEvent.eventCreationDate, currentEvent.createdBy, currentEvent.contributionAmount, currentEvent.contributionPool, currentEvent.totalAttendees, currentEvent.attendees, currentEvent.actualAttendees, currentEvent.actualTotalAttendees );
     }
}



// GOALS
//  verify ethereum transfers (ins / out)

//  Reading the blockchain log 
//      handling 'events'

// Login / Acct # 
// setup Admin