extends Node

var _score: int = 0
var _high_score: int = 0

func get_score() -> int:
	return _score
	
func get_high_score() -> int:
	return _high_score

func set_score(v: int) -> void:
	_score = v
	
	# Change high score if new score is higher than previous
	if _score > _high_score:
		_high_score = _score
		
	SignalManager.on_score_updated.emit()
		
func increment_score() -> void:
	set_score(_score + 1) 
	
