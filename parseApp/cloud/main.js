
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
