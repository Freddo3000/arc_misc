#include "script_component.hpp"

// See initSettings.sqf

params ["_unit"];
if (!local _unit) exitWith {};

// Init group
private _group = group _unit;
if (
	GVAR(enableAttack) isEqualTo 2 &&
	{_group getVariable [QGVAR(enabled), true]} &&
	{!(_group getVariable [QGVAR(initialized), false])}
) then {
	TRACE_1("Disabling attack on group", _group);
	_group enableAttack false;
	_group setVariable [QGVAR(initialized), true];
};

// Init unit
if ( GVAR(enabled) && {_unit getVariable [QGVAR(enabled), true]}) then {
	LOG_1("Setting AI skills on unit", _unit);

	{
		TRACE_2("Setting skill on unit", (_x # 0), (_x # 1));

		private _randomModifier = 1 - random GVAR(randomSkill) + random GVAR(randomSkill);
		_unit setSkill [_x # 0, (_x # 1) * _randomModifier];

	} forEach [
		["aimingAccuracy", GVAR(aimingAccuracy)],
		["aimingSpeed", GVAR(aimingSpeed)],
		["commanding", GVAR(commanding)],
		["courage", GVAR(courage)],
		["endurance", GVAR(endurance)],
		["general", GVAR(general)],
		["reloadSpeed", GVAR(reloadSpeed)],
		["spotDistance", GVAR(spotDistance)],
		["spotTime", GVAR(spotTime)],
		["aimingShake", GVAR(aimingShake)]
	];
};
_unit setVariable [QGVAR(initialized), true];
