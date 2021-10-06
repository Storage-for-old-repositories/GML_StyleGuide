
API_GML_WARN_ARGS ApiTimer;
API_GML_WARN_ARGS [__init, __tick, __kill];

#region abstract-class timer

function ApiTimer() constructor {
	
	#region __private
	
	static __init = apiFunctorEm /* handler   */;
	static __tick = apiFunctorEm /* arg, self */;
	static __kill = apiFunctorEm /* handler   */;
	
	#endregion
	
	static rem = function() {
		
		return apiTimerHandlerRem(self);
	}
	
	static isBind = function() {
		
		return apiTimerHandlerIsBind(self);
	}
	
	static set = function(_key, _data) {
		
		self[$ _key] = _data;
		return self;
	}
	
	static impl = function(_struct) {
		
		apiStructMerge(self, _struct, true);
		return self;
	}
	
}

#endregion

#region base timers

function ApiTimerSyncTimeout(_step, _ftick, _fkill) : __ApiTimerBaseTimeout(_step, _ftick, _fkill) constructor {
	
	#region __private
	
	static __tick = function(_arg) {
		
		if (self.__step > 0) {
			
			--self.__step;
			self.__ftick(_arg, self);
		}
		return (self.__step <= 0);
	}
	
	#endregion
	
}

#endregion


#region __private

function __ApiTimerBaseTimeout(_step, _ftick=apiFunctorEm, _fkill=apiFunctorEm) : ApiTimer() constructor {
	
	#region __private
	
	self.__step  = _step;
	self.__ftick = _ftick;
	self.__fkill = _fkill;
	
	static __kill = function(_handler) {
		
		self.__fkill(_handler);
	}
	
	#endregion
	
}

#endregion

