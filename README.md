PoC code for the issue regarding reentrant trigger handling during dml bulk execution.

Sometime Apex trigger is set not to be executed more than once on recurring updates.
But if some DML bulk update is executed with allOrNone = false, and some of records have validation error,
it will cause retry DML is issued for the non-error records,
which leads to bypass necessary trigger because the static flag is set for trigger reentrant management.
