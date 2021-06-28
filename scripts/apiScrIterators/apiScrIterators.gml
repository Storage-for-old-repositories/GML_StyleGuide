
// fInit = function(data, index, size)
// fIter = function(data, index, count)
/// @function apiIteratorRange(fInit, fIter, data, size|indexBegin, _indexEnd, _step)
/// @param fInit
/// @param fIter
/// @param data
/// @param size|indexBegin
/// @param _indexEnd
/// @param _step
function apiIteratorRange(_fInit, _fIter, _data, i, j, _step) {
	if (is_undefined(_step)) {
		
		if (is_undefined(j)) {
			j = i;
			i = 0;
		}
		_step = 1;
	}
	var _signStep = sign(_step);
	if (_signStep != 0) {
		var _size = j - i;
		if (sign(_size) == _signStep) {
			
			_size = _size div abs(_step) * _signStep;
			var _count = 0;
			
			if (!is_undefined(_fInit)) _fInit(_data, i, _size);
			while (_count < _size) {
				
				_fIter(_data, i, _count);
				i += _step;
				_count += 1;
			}
		}
		else {
			if (!is_undefined(_fInit)) _fInit(_data, i, 0);
		}
	}
	else {
		if (!is_undefined(_fInit)) _fInit(_data, i, 0);
	}
	return _data;
}


