unit BMTestSingleU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TBufferMathForm = class(TForm)
    TestCopyBtn: TButton;
    TestAddBtn: TButton;
    ResultMemo: TMemo;
    TestSubBtn: TButton;
    TestMulBtn: TButton;
    TestClearBtn: TButton;
    TestCopyBufBtn: TButton;
    TestMulAddBtn: TButton;
    TestAddMulBtn: TButton;
    TestAddScaledBtn: TButton;
    TestAddModulatedBtn: TButton;
    TestFindPeaksBtn: TButton;
    TestBufferSumsBtn: TButton;
    procedure TestCopyBtnClick(Sender: TObject);
    procedure TestAddBtnClick(Sender: TObject);
    procedure TestSubBtnClick(Sender: TObject);
    procedure TestMulBtnClick(Sender: TObject);
    procedure TestClearBtnClick(Sender: TObject);
    procedure TestCopyBufBtnClick(Sender: TObject);
    procedure TestMulAddBtnClick(Sender: TObject);
    procedure TestAddMulBtnClick(Sender: TObject);
    procedure TestAddScaledBtnClick(Sender: TObject);
    procedure TestAddModulatedBtnClick(Sender: TObject);
    procedure TestFindPeaksBtnClick(Sender: TObject);
    procedure TestBufferSumsBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


const TEST_DIM_1 = 20;
      TEST_DIM_2 = 512;
      TEST_RUNS  = 20000;

var
  BufferMathForm: TBufferMathForm;

implementation

{$R *.dfm}

uses DAVDCommon, DAVDBufferMathAsm, DAVDBufferMathPascal, DVSTEffect;

procedure GenerateTestBuffers(var input1,input2,input3, output: TAVDArrayOfSingleDynArray);
var i,j: integer;
begin
  setlength(input1, TEST_DIM_1, TEST_DIM_2);
  setlength(input2, TEST_DIM_1, TEST_DIM_2);
  setlength(input3, TEST_DIM_1, TEST_DIM_2);
  setlength(output, TEST_DIM_1, TEST_DIM_2);
  for i:=0 to TEST_DIM_1-1 do for j:=0 to TEST_DIM_2-1 do
  begin
    if i mod 2 = 0 then
      input1[i,j] := (j+1)
    else
      input1[i,j] := -1*(j+1);
      
    input2[i,j] := i+1;
    input3[i,j] := 15;
    output[i,j] := 5;
  end;
end;










procedure TBufferMathForm.TestCopyBtnClick(Sender: TObject);
var x: PPSingle; i,j: integer; n: TAVDArrayOfSingleDynArray;
begin
  getmem(x, 2*sizeof(PSingle));
  for j:=0 to 1 do
  begin
    getmem(x^, 200*sizeof(Single));
    for i:=0 to 199 do begin x^^:=i+(j*200); inc(x^); end;
    for i:=0 to 199 do dec(x^);
    inc(x);
  end;
  for j:=0 to 1 do dec(x);

  setlength(n,2);
  setlength(n[0],200);
  setlength(n[1],200);

  move(x^^,n[0,0],200*sizeof(single));
  inc(x);
  move(x^^,n[1,0],200*sizeof(single));
//  showmessage(floattostr(x^^));
  showmessage(floattostr(n[0,0]));
  showmessage(floattostr(n[1,45]));
end;







procedure TBufferMathForm.TestAddBtnClick(Sender: TObject);
var input1,input2,dummy, output: TAVDArrayOfSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin       
  ResultMemo.clear; refresh;
  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.AddArrays(input1, input2, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms adding with pure Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.AddArrays(input1, input2, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms adding with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.AddArrays(input1, 5,output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms adding single value with Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.AddArrays(input1, 5,output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms adding single value with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));    
  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;

procedure TBufferMathForm.TestSubBtnClick(Sender: TObject);
var input1,input2,dummy, output: TAVDArrayOfSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin   
  ResultMemo.clear; Refresh;
  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.SubArrays(input1, input2, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms subtracting with pure Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.SubArrays(input1, input2, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms subtracting with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.SubArrays(input1, 5,output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms subtracting single value with Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.SubArrays(input1, 5,output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms subtracting single value with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1])); 
  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;

procedure TBufferMathForm.TestMulBtnClick(Sender: TObject);
var input1,input2,dummy, output: TAVDArrayOfSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin     
  ResultMemo.clear; Refresh;
  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.MulArrays(input1, input2, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply with pure Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.MulArrays(input1, input2, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));  

  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.MulArrays(input1, 5,output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply single value with Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.MulArrays(input1, 5,output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply single value with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1])); 
  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;

procedure TBufferMathForm.TestClearBtnClick(Sender: TObject);
var dummy, output: TAVDArrayOfSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin  
  ResultMemo.clear; Refresh;
  GenerateTestBuffers(dummy, dummy, dummy, output);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.ClearArrays(output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms clear with pure Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));


  GenerateTestBuffers(dummy, dummy, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.ClearArrays(output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms clear with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1])); 
  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;  

procedure TBufferMathForm.TestCopyBufBtnClick(Sender: TObject);
var input, dummy, output: TAVDArrayOfSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin     
  ResultMemo.clear; Refresh;
  GenerateTestBuffers(input, dummy, dummy, output);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.CopyArrays(input, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms copy with pure Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input, dummy, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathASM.CopyArrays(input, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms copy with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));
  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;


procedure TBufferMathForm.TestMulAddBtnClick(Sender: TObject);
var input1,input2,input3, output: TAVDArrayOfSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin     
  ResultMemo.clear; Refresh;
  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.MulAddArrays(input1, input2, input3, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply then add with pure Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.MulAddArrays(input1, input2, input3, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply then add with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.MulAddArrays(input1, 5, input3, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply single value then add with Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.MulAddArrays(input1, 5, input3, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply single value then add with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.MulAddArrays(input1, input2, 5, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply then add single value with Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.MulAddArrays(input1, input2, 5, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply then add single value with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.MulAddArrays(input1, 5, 5, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply single value then add single value with Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.MulAddArrays(input1, 5, 5, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms multiply single value then add single value with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));   
  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;

procedure TBufferMathForm.TestAddMulBtnClick(Sender: TObject);
var input1,input2,input3, output: TAVDArrayOfSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin
  ResultMemo.clear; Refresh;
  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.AddMulArrays(input1, input2, input3, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add then multiply with pure Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.AddMulArrays(input1, input2, input3, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add then multiply with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.AddMulArrays(input1, 5, input3, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add single value then multiply with Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.AddMulArrays(input1, 5, input3, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add single value then multiply with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.AddMulArrays(input1, input2, 5, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add then multiply single value with Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.AddMulArrays(input1, input2, 5, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add then multiply single value with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.AddMulArrays(input1, 5, 5, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add single value then multiply single value with Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.AddMulArrays(input1, 5, 5, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add single value then multiply single value with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));
  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;



procedure TBufferMathForm.TestAddScaledBtnClick(Sender: TObject);
var input1,input2,dummy, output: TAVDArrayOfSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin
  ResultMemo.clear; Refresh;
  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.AddScaledArrays(input1, input2, 5, 5, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add scaled with pure Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, dummy, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.AddScaledArrays(input1, input2, 5, 5, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add scaled with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;

procedure TBufferMathForm.TestAddModulatedBtnClick(Sender: TObject);
var input1,input2,input3, output: TAVDArrayOfSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin
  ResultMemo.clear; Refresh;
  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.AddModulatedArrays(input1, input2, input3, input3, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add modulated with pure Pascal,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  GenerateTestBuffers(input1,input2, input3, output);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.AddModulatedArrays(input1, input2, input3, input3, output, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms add modulated with ASM,  Testvals: '
                           + floattostr(output[0,0]) + ' | '
                           + floattostr(output[0,TEST_DIM_2-1]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,0]) + ' | '
                           + floattostr(output[TEST_DIM_1-1,TEST_DIM_2-1]));

  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;

procedure TBufferMathForm.TestFindPeaksBtnClick(Sender: TObject);
var input1,input2,input3, output: TAVDArrayOfSingleDynArray;
    minpeaks, maxpeaks: TAVDSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin
  ResultMemo.clear; Refresh;
  GenerateTestBuffers(input1,input2, input3, output);
  setlength(minpeaks, TEST_DIM_1);
  setlength(maxpeaks, TEST_DIM_1);
  fillchar(minpeaks[0], TEST_DIM_1*sizeof(single), 0);
  fillchar(maxpeaks[0], TEST_DIM_1*sizeof(single), 0);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.GetPeaks(input1, minpeaks, maxpeaks, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms find peaks with pure Pascal,  Testvals: '
                           + floattostr(minpeaks[0]) + ' | '
                           + floattostr(maxpeaks[0]) + ' | '
                           + floattostr(minpeaks[TEST_DIM_1-1]) + ' | '
                           + floattostr(maxpeaks[TEST_DIM_1-1]));

  GenerateTestBuffers(input1,input2, input3, output);
  fillchar(minpeaks[0], TEST_DIM_1*sizeof(single), 0);
  fillchar(maxpeaks[0], TEST_DIM_1*sizeof(single), 0);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.GetPeaks(input1, minpeaks, maxpeaks, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms find peaks ASM,  Testvals: '
                           + floattostr(minpeaks[0]) + ' | '
                           + floattostr(maxpeaks[0]) + ' | '
                           + floattostr(minpeaks[TEST_DIM_1-1]) + ' | '
                           + floattostr(maxpeaks[TEST_DIM_1-1]));

  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;

procedure TBufferMathForm.TestBufferSumsBtnClick(Sender: TObject);
var input1,input2,input3, output: TAVDArrayOfSingleDynArray;
    minsums, maxsums: TAVDSingleDynArray;
    i: integer;
    A,B, freq: Int64;
begin
  ResultMemo.clear; Refresh;
  GenerateTestBuffers(input1,input2, input3, output);
  setlength(minsums, TEST_DIM_1);
  setlength(maxsums, TEST_DIM_1);
  fillchar(minsums[0], TEST_DIM_1*sizeof(single), 0);
  fillchar(maxsums[0], TEST_DIM_1*sizeof(single), 0);

  QueryPerformanceFrequency(freq);
  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathPascal.GetSums(input1, minsums, maxsums, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms find sums with pure Pascal,  Testvals: '
                           + floattostr(minsums[0]) + ' | '
                           + floattostr(maxsums[0]) + ' | '
                           + floattostr(minsums[TEST_DIM_1-1]) + ' | '
                           + floattostr(maxsums[TEST_DIM_1-1]));

  GenerateTestBuffers(input1,input2, input3, output);
  fillchar(minsums[0], TEST_DIM_1*sizeof(single), 0);
  fillchar(maxsums[0], TEST_DIM_1*sizeof(single), 0);

  QueryPerformanceCounter(A);
  for i:=0 to TEST_RUNS do
    DAVDBufferMathAsm.GetSums(input1, minsums, maxsums, TEST_DIM_1, TEST_DIM_2);

  QueryPerformanceCounter(B);
  ResultMemo.Lines.Add(FloatToStrF(((B-A)*1000)/freq, ffFixed,15,2)+ ' ms find sums ASM,  Testvals: '
                           + floattostr(minsums[0]) + ' | '
                           + floattostr(maxsums[0]) + ' | '
                           + floattostr(minsums[TEST_DIM_1-1]) + ' | '
                           + floattostr(maxsums[TEST_DIM_1-1]));

  ResultMemo.Lines.Add('---------------------------------------------------------------------------');
  ResultMemo.Lines.Add('DONE');
end;

end.
