var Memory = Parse.Object.extend("Memory");

Parse.Cloud.beforeSave("Memory", function(request, response) {
	incrementPosition(request.object, response);
});

function incrementPosition(memory, response) {
	lastMemoryQuery().find({
		success: function(objects) {
			var lastPosition = positionForMemory(objects[0]);
			memory.set("position", lastPosition + 1);
			response.success();
		},
		error: function(error) {
			response.error(error);
		}
	});
}

function lastMemoryQuery() {
	var query = new Parse.Query(Memory);
	query.descending("createdAt").limit(1);
	return query;
}

function positionForMemory(memory) {
	var position = 0;

	if (typeof memory != "undefined" && typeof memory.get("position") != "undefined") {
		position = memory.get("position");
	}	
	
	return position;
}


Parse.Cloud.define("randomMemory", function(request, response) {
	lastMemoryQuery().find({
		success: function(objects) {
			var lastPosition = positionForMemory(objects[0]);

			if (lastPosition == 0) {
				// error, should never happen
			}

			if (lastPosition == 1) {
				// don't return it because it will be their first memory they just saved.
			}

			var randomPosition = Math.ceil(Math.random()*lastPosition));
			
			var query = new Parse.Query(Memory);
			query.equalTo("position", randomPosition);
			query.find({
				success: function(objects) {
					var memory = objects[0];
					response.success(memory);
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
}