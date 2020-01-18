extends Node

func _ready():
	JavaScript.eval("kongregateAPI.loadAPI(function(){window.kongregate = kongregateAPI.getAPI();});")

func get_user_name():
	return JavaScript.eval("kongregate.services.getUsername();")

func submit_stats(stat, value):
	JavaScript.eval("kongregate.stats.submit('"+ stat +"', " + str(value) + ");")