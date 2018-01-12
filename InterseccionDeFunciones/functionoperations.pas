unit FunctionOperations;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Result, mOpenMethod, ClosedMethods, ParseMath;

type
  TFunOperations = class

    public
      AList,
      BList,
      BolzanoList: TStringList;
      constructor create();
      function bolzano( x1,x2: Double; fun: String): Integer;
      function evaluar(valorX : Real ; f_x : String ) : Real;
      //function intersection( f1, f2 : String; xmin, xmax, e: Double): TStringList;
      function intersection( f1, f2 : String; xmin, xmax, e: Double): TResult;
    private
      open: TOpenMethod;
      closed : TClosedMethods;
  end;

implementation

constructor TFunOperations.create();
begin
  open := TOpenMethod.Create();
  closed := TClosedMethods.create();
  AList := TStringList.Create();
  BList := TStringList.Create();
  BolzanoList := TStringList.Create();
end;

function TFunOperations.bolzano( x1,x2: Double; fun: String): Integer;
var
  fx1, fx2: Double;
begin
  fx1 := evaluar(x1,fun);
  fx2 := evaluar(x2,fun);

  if( fx1 = 0) then // x1 is the solution
      Result := 1
  else begin
    if( fx2 = 0) then // x2 is the solution
      Result := 2
    else begin
      if ( (fx1*fx2) < 0 ) then
        Result := 3
      else
        Result := 0
    end;
  end;

  {
  if( fx1 = 0) then begin
      Result := 1; // x1 is the solution
      exit;
  end;
  if( fx2 = 0) then begin
      Result := 2; // x2 is the solution
      exit;
  end;
  if ( (fx1*fx2) < 0 ) then begin
      //BolzanoList.Add();
      Result := 3; // success bolzano test
      exit;
  end;
  if ( (fx1*fx2) > 0 ) then begin
      Result := 0; //else  // don´t succes test
      exit;
  end;
  }
  //Result := ( (fx1*fx2) < 0 );
end;

function TFunOperations.evaluar(valorX : Real ; f_x : String ) : Real;
var
   MiParse : TParseMath;
begin
  try
   Miparse := TParseMath.create();
   MiParse.AddVariable('x',valorX);
   MiParse.Expression:= f_x;
   evaluar := MiParse.Evaluate();
  except
     evaluar:=0.0;
     Exit;
  end;
end;

// use closed method - parameter [ Point - 1 , Point +1]
// use open method - parameter [Result closed method]
{
function TFunOperations.intersection( f1, f2 : String; xmin, xmax, e: Double): TStringList;
var
  funExpression: String;
  xa, xb: Double;
  thereSolution : Integer;
  resultTemp: String;
  strTep : TStringlist;
begin
  Result := TStringList.Create;
  strTep := TStringList.Create;
  //strTep.Sort := True;
  strTep.Duplicates := dupIgnore;
  funExpression := f1 + '-(' + f2 + ')';
  xa:= xmin;
  while( xa <= xmax )do begin
    xb := xa + 0.5;
    thereSolution:= bolzano(xa,xb,funExpression);
    //xa := xb;
    //Result.result.Add( IntToStr(thereSolution));
    AList.Add( FloatToStr( xa ));
    BList.Add( FloatToStr( xb ));
    BolzanoList.Add( IntToStr(thereSolution));
    case thereSolution of
     0:
       Result.Add( 'No bolzano' );
     1:
       Result.Add( FloatToStr(xa) );
     2:
       Result.Add( FloatToStr(xb) );
     3:
       begin
         resultTemp := closed.bisectionMethod(xa,xb,0.01,funExpression).result;
         resultTemp := open.secante(StrToFloat(resultTemp),funExpression, e ).result;
         //resultTemp:='res';
         Result.Add( resultTemp );
       end;
    end;
    xa := xb;
  end;
end;
}

function TFunOperations.intersection( f1, f2 : String; xmin, xmax, e: Double): TResult;
var
  funExpression: String;
  xa, xb: Double;
  thereSolution : Integer;
  resultTemp: String;
begin
  Result.result := TStringList.Create;
  //Result.result.Sort := True;
  Result.result.Duplicates := dupIgnore;
  funExpression := f1 + '-(' + f2 + ')';
  xa:= xmin;
  while( xa <= xmax )do begin
    xb := xa + 0.5;
    thereSolution:= bolzano(xa,xb,funExpression);
    //xa := xb;
    //Result.result.Add( IntToStr(thereSolution));
    AList.Add( FloatToStr( xa ));
    BList.Add( FloatToStr( xb ));
    BolzanoList.Add( IntToStr(thereSolution));
    case thereSolution of
     //0:
       //Result.result.Add( 'No bolzano' );
     1:
       Result.result.Add( FloatToStr(xa) );
     2:
       Result.result.Add( FloatToStr(xb) );
     3:
       begin
         resultTemp := closed.bisectionMethod(xa,xb,0.01,funExpression).result;
         resultTemp := open.secante(StrToFloat(resultTemp),funExpression, e ).result;
         //resultTemp:='res';
         Result.result.Add( resultTemp );
       end;
    end;
    xa := xb;
  end;
end;

end.

