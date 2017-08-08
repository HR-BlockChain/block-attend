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
        uint totalAttendees;
        uint contributionAmount;
        uint contributionPool;
        address[] attendees;
        bool[] attendance;
        uint actualAttendees;
    }

    // initial Events
    function createEvent(string eventName, string eventLocation, uint eventDate, uint contributionAmount ) {
        
        events[eventName].eventLocation = eventLocation;
        events[eventName].eventDate = eventDate;
        events[eventName].eventCreationDate = now;
        events[eventName].contributionAmount = contributionAmount;

    }

    // Commit to joining event
    function joinEvent(string eventName) payable {

        var currentEvent = events[eventName];

        if (currentEvent.contributionAmount != msg.value) revert();

        currentEvent.attendees.push(msg.sender);
        currentEvent.attendance.push(false);
        currentEvent.totalAttendees = currentEvent.totalAttendees + 1;
        currentEvent.contributionPool = currentEvent.contributionPool + msg.value;

        totalAttendees = totalAttendees + 1;
    }

    // Current User must mark Event as attended . Trust System
    // more Ether as more attendees
    // need to Optimize
    function markAttended(string eventName) {
        // Set up GPS tracker

        var currentEvent = events[eventName];
        for (uint i = 0; i < totalAttendees; i++){
         if (currentEvent.attendees[i] == msg.sender){
                currentEvent.attendance[i] = true;
          }
        }
        currentEvent.actualAttendees = currentEvent.actualAttendees + 1;

        totalActualAttendees = totalActualAttendees + 1;
    }

    // payout after 24hrs after event;
    function payOut (string eventName) payable {

        var currentEvent = events[eventName];

        if (currentEvent.eventDate < now + 24 hours) revert();

        var payout = currentEvent.contributionPool / currentEvent.actualAttendees;

        for (uint i = 0; i < totalAttendees; i++){
            if (currentEvent.attendance[i] == true){
                // transfer payout to attendees[i] 
                currentEvent.attendees[i].transfer(payout);
            }
        }

    }

     function viewEvent(string eventName) constant returns(string, uint, uint, uint, uint, uint, address[], bool[], uint){
       var currentEvent = events[eventName];
        return (currentEvent.eventLocation, currentEvent.eventDate, currentEvent.eventCreationDate, currentEvent.totalAttendees, currentEvent.contributionAmount, currentEvent.contributionPool, currentEvent.attendees, currentEvent.attendance, currentEvent.actualAttendees);
     }
}



// GOALS
// verify ethereum transfers (ins / out)
// figure out payment 
//  page to view event / stats
//  verifying attendee page
