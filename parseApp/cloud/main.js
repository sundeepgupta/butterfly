// Public
Parse.Cloud.beforeSave("Memory", function(request, response) {
	_incrementPosition(request.object, response);
});

Parse.Cloud.afterSave("Memory", function(request) {
	_mailMemory(request.object);
});

function _mailMemory(memory, response) {
	var Mandrill = require('mandrill');
	Mandrill.initialize('cyYOeRQuFBaaEo5s8bSCSw');

	Mandrill.sendEmail({
	  message: _mailMessage(memory)
	}, {
	  success: function(httpResponse) {
	  	console.log(httpResponse);
	  },
	  error: function(httpResponse) {
	  	console.log(httpResponse);
	    response.error(httpResponse);
	  }
	});
}

function _mailMessage(memory) {
	var user = Parse.User.current();
	return {
    text: memory.get("thoughts"),
    subject: "Butterfly Daily Memories",
    from_email: "no-reply@butterfly-memories.com",
    from_name: "Butterly Memories App",
    to: [{email: user.get("username")}]
  }
}


Parse.Cloud.define("randomMemory", function(request, response) {
	_lastMemoryQuery().find({
		success: function(objects) {
			var lastPosition = _positionForMemory(objects[0]);

			if (lastPosition == 1) {
				response.success();
			}

			var randomPosition = _randomPosition(lastPosition);
			
			_memoryAtPositionQuery(randomPosition).find({
				success: function(objects) {
					response.success(objects[0]);
				},

				error: function(error) {
					response.error(error);
				}
			});
		},

		error: function(error) {
			response.error(error);
		}
	});
})


// Private
var Memory = Parse.Object.extend("Memory");

function _incrementPosition(memory, response) {
	_lastMemoryQuery().find({
		success: function(objects) {
			var lastPosition = _positionForMemory(objects[0]);
			memory.set("position", lastPosition + 1);
			response.success();
		},
		error: function(error) {
			response.error(error);
		}
	});
}

function _lastMemoryQuery() {
	var query = new Parse.Query(Memory);
	query.equalTo("user", Parse.User.current());
	query.descending("createdAt").limit(1);
	
	return query;
}

function _positionForMemory(memory) {
	var position = 0;

	if (memory != undefined && memory.get("position") != undefined) {
		position = memory.get("position");
	}	
	
	return position;
}

function _memoryAtPositionQuery(position) {
	var query = new Parse.Query(Memory);
	query.equalTo("user", Parse.User.current());
	query.equalTo("position", position);
	
	return query;
}

function _randomPosition(lastPosition) {
	// This gives us 1 through lastPosition - 1. We don't want to include lastPosition
	// because it corresponds to the memory that was just saved.

	var maxPosition = lastPosition - 1;
	
	return Math.floor(Math.random()*maxPosition) + 1;
}
