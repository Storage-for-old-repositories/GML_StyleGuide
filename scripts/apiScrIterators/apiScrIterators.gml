
// fInit = function(data, index, size)
// fIter = function(data, index, count)
/// @function apiIteratorRange(fInit, fIter, data, size|indexBegin, ?indexEnd, ?step)
/// @param fInit
/// @param fIter
/// @param data
/// @param size|indexBegin
/// @param ?indexEnd
/// @param ?step
function apiIteratorRange(_fInit, _fIter, _data, _i, _j, _step) {
	if (is_undefined(_step)) {
		
		if (is_undefined(_j)) {
			_j = _i;
			_i = 0;
		}
		_step = 1;
	}
	var _signStep = sign(_step);
	if (_signStep != 0) {
		var _size = _j - _i;
		if (sign(_size) == _signStep) {
			
			_size = _size div abs(_step) * _signStep;
			var _count = 0;
			
			if (!is_undefined(_fInit)) {
				
				if (_fInit(_data, _i, _size)) {
					
					_count += 1;
					_i += _step;
				}
			}
			while (_count < _size) {
				
				_fIter(_data, _i, _count++);
				_i += _step;
			}
		}
		else {
			if (!is_undefined(_fInit)) _fInit(_data, _i, 0);
		}
	}
	else {
		if (!is_undefined(_fInit)) _fInit(_data, _i, 0);
	}
	return _data;
}


