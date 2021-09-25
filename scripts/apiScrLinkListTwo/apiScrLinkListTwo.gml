

#region class

function ApiLListT() : ApiLListO() constructor {
	
	#region __private
	
	self.__lst = undefined;
	
	static __build = function(_value, _next, _prev) {
		
		return [_value, _next, _prev];
	}
	
	#endregion
	
	static insBegin = function(_value) {
		
		_value = self.__build(_value, self.__fst, undefined);
		
		if (self.__lst == undefined) {
			
			self.__lst = _value;
		}
		else {
			
			self.__fst[@ __API_LINK_LIST.PREV] = _value;
		}
		
		self.__fst = _value;
		return self.__fst;
	}
	
	static insEnd = function(_value) {
		
		_value = self.__build(_value, undefined, self.__lst);
		
		if (self.__fst == undefined) {
			
			self.__fst = _value;
		}
		else {
			
			self.__lst[@ __API_LINK_LIST.NEXT] = _value;
		}
		
		self.__lst = _value;
		return self.__lst;
	}
	
	static insAfter = function(_value, _cell) {
		
		_value = self.__build(_value, _cell[__API_LINK_LIST.NEXT], _cell);
		_cell[@ __API_LINK_LIST.NEXT] = _value;
		
		if (_cell == self.__lst) {
			
			self.__lst = _cell;
		}
		
		return _value;
	}
	
	static insBefore = function(_value, _cell) {
		
		_value = self.__build(_value, _cell, _cell[__API_LINK_LIST.PREV]);
		_cell[@ __API_LINK_LIST.PREV] = _value;
		
		if (_cell == self.__fst) {
			
			self.__fst = _cell;
		}
		
		return _value;
	}
	
	static popBegin = function() {
		
		var _value = self.__fst;
		self.__fst = _value[__API_LINK_LIST.NEXT];
		
		if (self.__fst == undefined) {
			
			self.__lst = undefined;
		}
		else {
			
			self.__fst[@ __API_LINK_LIST.PREV] = undefined;
		}
		
		return _value;
	}
	
	static topEnd = function() {
		
		return self.__lst;
	}
	
	static popEnd = function() {
		
		var _value = self.__lst;
		self.__lst = _value[__API_LINK_LIST.PREV];
		
		if (self.__lst == undefined) {
			
			self.__fst = undefined;
		}
		else {
			
			self.__lst[@ __API_LINK_LIST.NEXT] = undefined;
		}
		
		return _value;
	}
	
	static rem = function(_cell) {
		
		var _next = _cell[__API_LINK_LIST.NEXT];
		var _prev = _cell[__API_LINK_LIST.PREV];
		
		if (_next != undefined) {
			
			_next[@ __API_LINK_LIST.PREV] = _prev;
		}
		else {
			
			self.__lst = _prev;
		}
		
		if (_prev != undefined) {
			
			_prev[@ __API_LINK_LIST.NEXT] = _next;
		}
		else {
			
			self.__fst = _next;
		}
	}
	
	static swpRef = function(_cell1, _cell2) {
		
		if (_cell1 == _cell2) exit;
		
		var _prev1 = _cell1[__API_LINK_LIST.PREV];
		var _next1 = _cell1[__API_LINK_LIST.NEXT];
		var _prev2 = _cell2[__API_LINK_LIST.PREV];
		var _next2 = _cell2[__API_LINK_LIST.NEXT];
		
		_cell1[@ __API_LINK_LIST.PREV] = _prev2;
		_cell1[@ __API_LINK_LIST.NEXT] = _next2;
		_cell2[@ __API_LINK_LIST.PREV] = _prev1;
		_cell2[@ __API_LINK_LIST.NEXT] = _next1;
		
		if (_prev1 != undefined)
			_prev1[@ __API_LINK_LIST.NEXT] = _cell2;
		
		if (_next1 != undefined)
			_next1[@ __API_LINK_LIST.PREV] = _cell2;
		
		if (_prev2 != undefined)
			_prev2[@ __API_LINK_LIST.NEXT] = _cell1;
		
		if (_next2 != undefined)
			_next2[@ __API_LINK_LIST.PREV] = _cell1;
		
		if (_cell1 == self.__fst) {
			
			self.__fst = _cell2;
		}
		else
		if (_cell2 == self.__fst) {
			
			self.__fst = _cell1;
		}
		
		if (_cell1 == self.__lst) {
			
			self.__lst = _cell2;
		}
		else
		if (_cell2 == self.__lst) {
			
			self.__lst = _cell1;
		}
	}
	
	static clear = function() {
		
		self.__fst = undefined;
		self.__lst = undefined;
	}
	
	static toClone = function(_f=apiFunctorId, _data) {
		
		var _clone = new ApiLListT();
		var _cell = self.__fst;
		if (_cell != undefined) {
			
			var _ceilBuild = _clone.insBegin(_f(_cell[__API_LINK_LIST.VALUE], _data));
			_cell          = _cell[__API_LINK_LIST.NEXT];
			
			while (_cell != undefined) {
				
				_ceilBuild = _clone.insAfter(_f(_cell[__API_LINK_LIST.VALUE], _data), _ceilBuild);
				_cell      = _cell[__API_LINK_LIST.NEXT];
			}
		}
		return _clone;
	}
	
}

#endregion

#region functions

function apiLListTGetPrev(_cell) {
		
	return _cell[__API_LINK_LIST.PREV];
}

#endregion


#region tests - One
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL true;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrLinkListTwo 1"
		);
		
		var _lolist = new ApiLListT();
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[]
			),
			"<apiScrLinkListTwo empty>"
		);
		
		apiDebugAssert(
			_lolist.mathSize() == 0,
			"<apiScrLinkListTwo size empty>"
		);
		
		var _lolist_clone = _lolist.toClone();
		_lolist.insBegin(4);
		
		apiDebugAssert(
			array_equals(
				_lolist_clone.toArray(),
				[]
			),
			"<apiScrLinkListTwo empty clone>"
		);
		
		apiDebugAssert(
			_lolist_clone.mathSize() == 0,
			"<apiScrLinkListTwo size empty clone>"
		);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[4]
			),
			"<apiScrLinkListTwo insBegin 1>"
		);
		
		apiDebugAssert(
			_lolist.mathSize() == 1,
			"<apiScrLinkListTwo insBegin size 1>"
		);
		
		_lolist.insBegin(8);
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[8, 4]
			),
			"<apiScrLinkListTwo insBegin 1>"
		);
		
		apiDebugAssert(
			_lolist.mathSize() == 2,
			"<apiScrLinkListTwo insBegin size 1>"
		);
		
		apiDebugAssert(
			array_equals(
				_lolist_clone.toArray(),
				[]
			),
			"<apiScrLinkListTwo empty clone 2>"
		);
		
		apiDebugAssert(
			_lolist_clone.mathSize() == 0,
			"<apiScrLinkListTwo size empty clone 2>"
		);
		
		var _pop;
		
		_pop = _lolist.popBegin();
		apiDebugAssert(
			apiLListOGetVal(_pop) == 8,
			"<apiScrLinkListTwo getValue 1>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(apiLListOGetNext(_pop)) == 4,
			"<apiScrLinkListTwo getValue 1 next>"
		);
		
		apiDebugAssert(
			_lolist.mathSize() == 1,
			"<apiScrLinkListTwo getValue 1 size>"
		);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[4]
			),
			"<apiScrLinkListTwo getValue 1 check>"
		);
		
		_pop = _lolist.popBegin();
		apiDebugAssert(
			apiLListOGetVal(_pop) == 4,
			"<apiScrLinkListTwo getValue 2>"
		);
		
		apiDebugAssert(
			apiLListOGetNext(_pop) == undefined,
			"<apiScrLinkListTwo getValue 2 next>"
		);
		
		apiDebugAssert(
			_lolist.mathSize() == 0,
			"<apiScrLinkListTwo getValue 2 size>"
		);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[]
			),
			"<apiScrLinkListTwo getValue 2 check>"
		);
		
		apiDebugAssert(
			_lolist.topBegin() == undefined,
			"<apiScrLinkListTwo getValue empty>"
		);
		
		_lolist = new ApiLListT();
		
		var _v1 = _lolist.insBegin(4);
		var _v2 = _lolist.insBegin(8);
		
		apiLListOSwpVal(_v1, _v2);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[4, 8]
			),
			"<apiScrLinkListTwo swapValue>"
		);
		
		_lolist.rem(_v1, _v2);
		_lolist.insAfter("Hello", _v2);
		apiLListOSetVal(_v2, "World");
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				["World", "Hello"]
			),
			"<apiScrLinkListTwo remValue>"
		);
		
		_lolist = new ApiLListT();
		_lolist.insBegin(4);
		_lolist.insBegin(8);
		var _arr = [];
		_lolist.call(function(_v, _a) {
			array_push(_a, _v);
		}, _arr);
		
		apiDebugAssert(
			array_equals(
				_arr,
				[8, 4]
			),
			"<apiScrLinkListTwo call>"
		);
		
		var _clone = _lolist.toClone();
		
		var _v1 = _lolist.topBegin();
		var _v2 = apiLListOGetNext(_v1);
		
		apiLListOSwpVal(_v1, _v2);
		_lolist.insAfter(16, _v2);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[4, 8, 16]
			),
			"<apiScrLinkListTwo swp 1>"
		);
		
		apiDebugAssert(
			array_equals(
				_clone.toArray(),
				[8, 4]
			),
			"<apiScrLinkListTwo swp 2>"
		);
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

#region tests - Two
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL true;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrLinkListTwo 2"
		);
		
		var _l = new ApiLListT();
		_l.insEnd(4);
		_l.insEnd(5);
		_l.insEnd(6);
		_l.insEnd(7);
		
		apiDebugAssert(
			array_equals(
				_l.toArray(),
				[4, 5, 6, 7]
			),
			"<apiScrLinkListTwo insEnd>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(_l.topBegin()) == 4,
			"<apiScrLinkListTwo insEnd check begin>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(_l.topEnd()) == 7,
			"<apiScrLinkListTwo insEnd check end>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(_l.popBegin()) == 4,
			"<apiScrLinkListTwo insEnd check begin pop 1>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(_l.popEnd()) ==7,
			"<apiScrLinkListTwo insEnd check end pop 1>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(_l.topBegin()) == 5,
			"<apiScrLinkListTwo insEnd check begin pop 2>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(_l.topEnd()) == 6,
			"<apiScrLinkListTwo insEnd check end pop 2>"
		);
		
		var _b = _l.insBegin(11);
		var _e = _l.insEnd(77);
		
		apiDebugAssert(
			apiLListOGetVal(_l.topBegin()) == 11,
			"<apiScrLinkListTwo insEnd check begin pop 3>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(_l.topEnd()) == 77,
			"<apiScrLinkListTwo insEnd check end pop 3>"
		);
		
		_l.swpRef(_b, _e);
		
		apiDebugAssert(
			_l.topBegin() == _e,
			"<apiScrLinkListTwo swpRef a>"
		);
		
		apiDebugAssert(
			_l.topEnd() == _b,
			"<apiScrLinkListTwo swpRef b>"
		);
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion
