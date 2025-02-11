
// Event Node: stores the code and condition to move to the next node

// the Event function is a function pointer that is ran to  run every frame as the event is being ran
// the condition fucntion is the qualifier to move on to the next event

enum eventNodeType
{
	LINEAR_NODE = 0,
	BRANCH_NODE = 1
}

function EventBranchNode(_eventFunction, _conditionFunction)
{
	branchType = eventNodeType.LINEAR_NODE;
	eventFunctions = [_eventFunction];
	conditions = [_conditionFunction];
	next = noone;
}


function EventNode(_eventFunction, _conditionFunction) constructor
{
	branchType = eventNodeType.BRANCH_NODE;
	eventFunction = _eventFunction;
	condition = _conditionFunction;
	next = noone;
}

// Class for adding events to game maker.

function event() constructor
{
	head = noone;
	size = 0;
	
	// Adds event to linked list and returns it's reference.
	function addEvent(_eventFunction = noone, _conditionFunction = noone)
	{
		var newEvent = new EventNode(_eventFunction, _conditionFunction);
		
		if(head == noone)
			head = newEvent;
		else
		{
			var current = head;
			
			while(current.next)
				current = current.next;
				
			current.next = newEvent;
		}
		
		++size;
		
		return newEvent;
	}
	
	function addBranch(_eventFunction = [], _conditionFunction = [])
	{
		var newEvent = new EventBranchNode(_eventFunction = [], _conditionFunction = [])
		
		if(head == noone)
			head = newEvent;
		else
		{
			var current = head;
			
			while(current.next)
				current = current.next;
				
			current.next = newEvent;
		}
		
		++size;
		
		return newEvent;
	}
	
	function insertEvent(_index = 0, _eventFunction = noone, _conditionFunction = noone) 
	{
	    var newEvent = new EventNode(_eventFunction, _conditionFunction);

	    if (head == noone) 
	        head = newEvent;
		else 
		{
	        var previous = noone;
	        var currentIndex = 0;

	        for (var current = head; current != noone; current = current.next) 
			{
	           
			   if (currentIndex == _index) 
			   {
				   
	                if (!_isBranch) 
					{
	                    newEvent.next = current;
	                    if (previous != noone) previous.next = newEvent;
	                    else head = newEvent; // Handles case when _index is 0
	                    show_debug_message("Node Inserted!");
	                }
					
	                ++size; 
	                return newEvent;
	            }
	            previous = current;
	            currentIndex++;
	        }

	        // If index is beyond the list, append at the end
	        if (currentIndex == _index) 
			{
	            previous.next = newEvent;
	            show_debug_message("Node Inserted at the end!");
	            ++size;
	        }
	    }

	    return newEvent;
	}
	
	// Returns the size of the linked list
	function getSize()
	{
		return size;	
	}
	
	// Runs active events
	function runEventChain() {
	    var current = head;

	    while (current) {
	        // Skip the event if the condition is true
		
			
	        if (current.condition() == true) {
	            current = current.next;
	            continue;
	        }


	        // Run the event function if no branch is taken and it exists
	        if (current.branchType = eventNodeType.LINEAR_NODE) {
	            current.eventFunction();
	            return;  // Exit the chain after running the main event
	        }

	        current = current.next;
	    }
	}
	
    // Clean up all event nodes
    function eventClean()
    {
        var current = head;
        var temp;

        while (current != noone)
        {
            temp = current.next;  
            current.next = noone;  
            current = temp;       
        }

        head = noone;
        size = 0;
    }
}