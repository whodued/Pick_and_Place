PROGRAM sorting_station
  VAR
    sort_1_shift : WORD;
    sort_2_shift : WORD;
    sort_3_shift : WORD;
    timer_1 : BOOL;
    timer_2 : BOOL;
    timer_3 : BOOL;
    reset_1 : BOOL;
    reset_2 : BOOL;
    reset_3 : BOOL;
  END_VAR
  VAR
    at_exit AT %QX0.0 : BOOL;
    start AT %QX0.1 : BOOL;
    reset AT %QX0.2 : BOOL;
    stop AT %QX0.3 : BOOL;
    emergency_stop AT %QX0.4 : BOOL;
    auto AT %QX0.5 : BOOL;
    factory_io_running AT %QX0.6 : BOOL;
    entry_conveyor AT %QX1.0 : BOOL;
    stop_blade AT %QX0.7 : BOOL;
    exit_conveyor AT %QX1.1 : BOOL;
    sorter_1_turn AT %QX1.2 : BOOL;
    sorter_1_belt AT %QX1.3 : BOOL;
    sorter_2_turn AT %QX1.4 : BOOL;
    sorter_2_belt AT %QX1.5 : BOOL;
    sorter_3_turn AT %QX1.6 : BOOL;
    sorter_3_belt AT %QX1.7 : BOOL;
    start_light AT %QX2.0 : BOOL;
    reset_light AT %QX2.1 : BOOL;
    stop_light AT %QX2.2 : BOOL;
    vision_sensor AT %QW0 : INT;
    counter_1 AT %QW1 : INT;
    counter_2 AT %QW2 : INT;
    counter_3 AT %QW3 : INT;
  END_VAR
  VAR
    CTU0 : CTU;
    CTU1 : CTU;
    CTU2 : CTU;
    TON0 : TON;
    TOF0 : TOF;
    TON1 : TON;
    TOF1 : TOF;
    TON2 : TON;
    TOF2 : TOF;
    R_TRIG1 : R_TRIG;
    R_TRIG2 : R_TRIG;
    R_TRIG3 : R_TRIG;
    R_TRIG4 : R_TRIG;
    _TMP_EQ46_OUT : BOOL;
    _TMP_EQ49_OUT : BOOL;
    _TMP_MOVE52_ENO : BOOL;
    _TMP_MOVE52_OUT : WORD;
    _TMP_SHL57_ENO : BOOL;
    _TMP_SHL57_OUT : WORD;
    _TMP_EQ62_OUT : BOOL;
    _TMP_EQ76_OUT : BOOL;
    _TMP_EQ79_OUT : BOOL;
    _TMP_MOVE82_ENO : BOOL;
    _TMP_MOVE82_OUT : WORD;
    _TMP_SHL87_ENO : BOOL;
    _TMP_SHL87_OUT : WORD;
    _TMP_EQ92_OUT : BOOL;
    _TMP_GE107_OUT : BOOL;
    _TMP_MOVE113_ENO : BOOL;
    _TMP_MOVE113_OUT : WORD;
    _TMP_SHL118_ENO : BOOL;
    _TMP_SHL118_OUT : WORD;
    _TMP_EQ123_OUT : BOOL;
  END_VAR

  start_light := auto AND emergency_stop AND stop AND (start OR start_light);
  stop_light := NOT(start_light);
  entry_conveyor := start_light;
  exit_conveyor := start_light;
  sorter_1_belt := start_light;
  sorter_2_belt := start_light;
  sorter_3_belt := start_light;
  R_TRIG1(CLK := sorter_1_turn);
  CTU0(EN := TRUE, CU := R_TRIG1.Q, R := reset OR reset_1, PV := 32767);
  reset_1 := CTU0.Q;
  IF CTU0.ENO THEN
      counter_1 := CTU0.CV;
  END_IF;
  R_TRIG2(CLK := sorter_2_turn);
  CTU1(EN := TRUE, CU := R_TRIG2.Q, R := reset OR reset_2, PV := 32767);
  reset_2 := CTU1.Q;
  IF CTU1.ENO THEN
      counter_2 := CTU1.CV;
  END_IF;
  R_TRIG3(CLK := sorter_3_turn);
  R_TRIG4(CLK := R_TRIG3.Q);
  CTU2(EN := TRUE, CU := R_TRIG4.Q, R := reset OR reset_3, PV := 32767);
  reset_3 := CTU2.Q;
  IF CTU2.ENO THEN
      counter_3 := CTU2.CV;
  END_IF;
  TON0(IN := NOT(timer_1) AND start_light, PT := T#100MS);
  timer_1 := TON0.Q;
  _TMP_EQ46_OUT := EQ(vision_sensor, 1);
  _TMP_EQ49_OUT := EQ(vision_sensor, 4);
  _TMP_MOVE52_OUT := MOVE(EN := _TMP_EQ46_OUT OR _TMP_EQ49_OUT, IN := 1, ENO => _TMP_MOVE52_ENO);
  IF _TMP_MOVE52_ENO THEN
      sort_1_shift := _TMP_MOVE52_OUT;
  END_IF;
  _TMP_SHL57_OUT := SHL(EN := timer_1 AND start_light, IN := sort_1_shift, N := 1, ENO => _TMP_SHL57_ENO);
  IF _TMP_SHL57_ENO THEN
      sort_1_shift := _TMP_SHL57_OUT;
  END_IF;
  _TMP_EQ62_OUT := EQ(sort_1_shift, 2);
  TOF0(IN := _TMP_EQ62_OUT, PT := T#1S);
  sorter_1_turn := TOF0.Q OR _TMP_EQ62_OUT;
  TON1(IN := NOT(timer_2) AND start_light, PT := T#100MS);
  timer_2 := TON1.Q;
  _TMP_EQ76_OUT := EQ(vision_sensor, 2);
  _TMP_EQ79_OUT := EQ(vision_sensor, 3);
  _TMP_MOVE82_OUT := MOVE(EN := _TMP_EQ76_OUT OR _TMP_EQ79_OUT, IN := 1, ENO => _TMP_MOVE82_ENO);
  IF _TMP_MOVE82_ENO THEN
      sort_2_shift := _TMP_MOVE82_OUT;
  END_IF;
  _TMP_SHL87_OUT := SHL(EN := timer_2 AND start_light, IN := sort_2_shift, N := 1, ENO => _TMP_SHL87_ENO);
  IF _TMP_SHL87_ENO THEN
      sort_2_shift := _TMP_SHL87_OUT;
  END_IF;
  _TMP_EQ92_OUT := EQ(sort_2_shift, 16);
  TOF1(IN := _TMP_EQ92_OUT, PT := T#2.5S);
  sorter_2_turn := TOF1.Q OR _TMP_EQ92_OUT;
  TON2(IN := NOT(timer_3) AND start_light, PT := T#100MS);
  timer_3 := TON2.Q;
  _TMP_GE107_OUT := GE(vision_sensor, 5);
  _TMP_MOVE113_OUT := MOVE(EN := _TMP_GE107_OUT, IN := 1, ENO => _TMP_MOVE113_ENO);
  IF _TMP_MOVE113_ENO THEN
      sort_3_shift := _TMP_MOVE113_OUT;
  END_IF;
  _TMP_SHL118_OUT := SHL(EN := timer_3 AND start_light, IN := sort_3_shift, N := 1, ENO => _TMP_SHL118_ENO);
  IF _TMP_SHL118_ENO THEN
      sort_3_shift := _TMP_SHL118_OUT;
  END_IF;
  _TMP_EQ123_OUT := EQ(sort_3_shift, 128);
  TOF2(IN := _TMP_EQ123_OUT, PT := T#4.5S);
  sorter_3_turn := TOF2.Q OR _TMP_EQ123_OUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : sorting_station;
  END_RESOURCE
END_CONFIGURATION
