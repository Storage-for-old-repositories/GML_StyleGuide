
#region Ordered

enum API_COMPARATOR {LT = -1, EQ = 0, GT = 1};

/// @function apiComparatorNumber(left, right);
/// @param left
/// @param right
function apiComparatorNumber(_left, _right) {
	
	/*
		apiComparatorNumber(2.0000242, 2.0000242) -> API_COMPARATOR.EQ
		apiComparatorNumber(5, 5)                 -> API_COMPARATOR.EQ
		
		apiComparatorNumber(2.0000242, 2.0000243) -> API_COMPARATOR.LT
		apiComparatorNumber(2, 5)                 -> API_COMPARATOR.LT
		
		apiComparatorNumber(2.0000243, 2.0000242) -> API_COMPARATOR.GT
		apiComparatorNumber(5, 2)                 -> API_COMPARATOR.GT
	*/
	
	var _comp = sign(_left - _right);
	if (_comp == 0) {
		return API_COMPARATOR.EQ;
	}
	else
	if (_comp == 1) {
		return API_COMPARATOR.GT;
	}
	return API_COMPARATOR.LT;
}

/// @function apiComparatorStringLexical(left, right);
/// @param left
/// @param right
function apiComparatorStringLexical(_left, _right) { // лексикографическое (вроде как)

	/*
		apiComparatorStringLexical("aa", "aa") -> API_COMPARATOR.EQ
		apiComparatorStringLexical("", "")     -> API_COMPARATOR.EQ
		
		apiComparatorStringLexical("aa", "ab") -> API_COMPARATOR.LT
		apiComparatorStringLexical("a", "ab")  -> API_COMPARATOR.LT
		apiComparatorStringLexical("", "ab")   -> API_COMPARATOR.LT
		
		apiComparatorStringLexical("2", "1")   -> API_COMPARATOR.GT
		apiComparatorStringLexical("2", "11")  -> API_COMPARATOR.GT
		apiComparatorStringLexical("2", "")    -> API_COMPARATOR.GT
	*/
	
	var _sizeLeft = string_length(_left);
	var _sizeRight = string_length(_right);
	
	var _charLeft, _charRight;
	for (var _i = 1; _i <= _sizeLeft; _i++) {
		
		_charLeft = string_char_at(_left, _i);
		_charRight = string_char_at(_right, _i);
		
		if (_charLeft != _charRight)
			return apiComparatorNumber(ord(_charLeft), ord(_charRight));
		
		if (_i == _sizeRight) break;
	}
	
	return apiComparatorNumber(_sizeLeft, _sizeRight);
}

/// @function apiComparatorStringLexical(left, right);
/// @param left
/// @param right
function apiComparatorStringLength(_left, _right) { // по длинам строк
	return apiComparatorNumber(string_length(_left), string_length(_right));
}

#endregion
