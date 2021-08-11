PoC code for the issue regarding reentrant trigger handling during dml bulk execution.

Sometime Apex trigger is set not to be executed more than once on recurring updates.
But if some DML bulk update is executed with allOrNone = false, retry DML is issued for the non-error records,
which can be bypassed if the static flag is set on the trigger reentrant management.
