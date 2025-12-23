-- Hardware manager i guess
HEX
8000 CONSTANT HW-BASE-ADDR
VARIABLE HW-STATUS
0 HW-STATUS !

: INIT-HW ( -- )
  ." Initializing Hardware..." CR
  HW-BASE-ADDR @ .
  0 HW-STATUS !
;
(
    : UNIT-HW
  ." Uninitializing Hardware..." CR
  HW-STATUS @ IF
    HW-BASE-ADDR @ .
    1 HW-STATUS !
  ELSE
    ." Hardware already uninitialized." CR
  THEN
;
)