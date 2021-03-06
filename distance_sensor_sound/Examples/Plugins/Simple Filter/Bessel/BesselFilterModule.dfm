object VSTFilter: TVSTFilter
  OldCreateOrder = False
  OnCreate = VSTModuleCreate
  OnDestroy = VSTModuleDestroy
  Flags = [effFlagsCanReplacing, effFlagsCanDoubleReplacing]
  Version = '1.0'
  EffectName = 'Delphi VST Filter'
  ProductName = 'Delphi VST Filter'
  VendorName = 'Delphi VST'
  VersionMajor = 1
  VersionMinor = 0
  VersionRelease = 0
  PlugCategory = vpcEffect
  TailSize = 0
  CanDos = [vcdPlugAsChannelInsert, vcdPlugAsSend, vcd1in1out, vcd1in2out, vcd2in1out, vcd2in2out]
  SampleRate = 44100.000000000000000000
  numCategories = 1
  CurrentProgram = 0
  CurrentProgramName = 'Preset 1'
  KeysRequired = False
  UniqueID = 'Filt'
  ShellPlugins = <>
  Programs = <
    item
      DisplayName = 'Preset 1'
      VSTModule = Owner
    end
    item
      DisplayName = 'Preset 2'
      VSTModule = Owner
    end
    item
      DisplayName = 'Preset 3'
      VSTModule = Owner
    end>
  ParameterProperties = <
    item
      Min = 20.000000000000000000
      Max = 20000.000000000000000000
      Curve = ctLinear
      DisplayName = 'Cutoff Frequency'
      Units = 'Hz'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      CanBeAutomated = True
      ReportVST2Properties = False
      StepFloat = 100.000000000000000000
      SmallStepFloat = 100.000000000000000000
      LargeStepFloat = 1000.000000000000000000
      Flags = []
      MinInteger = 20
      MaxInteger = 20000
      StepInteger = 100
      LargeStepInteger = 1000
      ShortLabel = 'Cutoff'
      VSTModule = Owner
      OnParameterChange = VSTFilterFrequencyChange
    end>
  OnProcess = VSTModuleProcess
  OnProcessReplacing = VSTModuleProcess
  OnProcessDoubleReplacing = VSTModuleProcessDoubleReplacing
  OnInitialize = VSTModuleInitialize
  Left = 443
  Top = 102
  Height = 150
  Width = 215
end
