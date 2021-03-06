object MBCDataModule: TMBCDataModule
  OldCreateOrder = False
  OnCreate = VSTModuleCreate
  OnDestroy = VSTModuleDestroy
  Flags = [effFlagsHasEditor]
  Version = '0.0'
  EffectName = 'Multiband Compressor'
  ProductName = 'Multiband Compressor'
  VendorName = 'Delphi ASIO & VST'
  PlugCategory = vpcEffect
  CanDos = []
  SampleRate = 44100.000000000000000000
  CurrentProgram = -1
  UniqueID = 'MBCo'
  ShellPlugins = <>
  Programs = <>
  ParameterProperties = <
    item
      Min = -15.000000000000000000
      Max = 15.000000000000000000
      Curve = ctLinear
      DisplayName = 'Low Gain'
      Units = 'dB'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 0.100000001490116100
      SmallStepFloat = 0.009999999776482582
      LargeStepFloat = 1.000000000000000000
      MinInteger = -15
      MaxInteger = 15
      LargeStepInteger = 2
      ShortLabel = 'LowGain'
      VSTModule = Owner
      OnParameterChange = MBCDMLowGainChange
    end
    item
      Min = 20.000000000000000000
      Max = 20000.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'Low Frequency'
      Units = 'Hz'
      CurveFactor = 1000.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 100.000000000000000000
      SmallStepFloat = 10.000000000000000000
      LargeStepFloat = 1000.000000000000000000
      Flags = [kVstParameterUsesFloatStep]
      MinInteger = 20
      MaxInteger = 20000
      StepInteger = 100
      LargeStepInteger = 1000
      ShortLabel = 'LowFreq'
      VSTModule = Owner
      OnParameterChange = MBCDMLowFrequencyChange
    end
    item
      Min = 1.000000000000000000
      Max = 10.000000000000000000
      Curve = ctLinear
      DisplayName = 'Low Order'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 2.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 4.000000000000000000
      Flags = [kVstParameterUsesIntegerMinMax]
      MinInteger = 1
      MaxInteger = 0
      StepInteger = 2
      ShortLabel = 'LowOrd'
      VSTModule = Owner
      OnParameterChange = MBCDCLowOrderChange
    end
    item
      Min = -48.000000000000000000
      Max = 6.000000000000000000
      Curve = ctLinear
      DisplayName = 'Low Threshold'
      Units = 'dB'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 0.100000001490116100
      LargeStepFloat = 3.000000000000000000
      MinInteger = -48
      MaxInteger = 6
      LargeStepInteger = 3
      ShortLabel = 'LowThrs'
      VSTModule = Owner
      OnParameterChange = MBCDMLowThresholdChange
    end
    item
      Min = 1.000000000000000000
      Max = 10.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'Low Ratio'
      CurveFactor = 10.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 1.000000000000000000
      MinInteger = 1
      MaxInteger = 10
      LargeStepInteger = 1
      ShortLabel = 'LoRatio'
      VSTModule = Owner
      OnParameterChange = MBCDMLowRatioChange
    end
    item
      Min = 10.000000000000000000
      Max = 1000.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'Low Attack'
      Units = 'ms'
      CurveFactor = 100.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 10.000000000000000000
      MinInteger = 10
      MaxInteger = 1000
      ShortLabel = 'LowAtt'
      VSTModule = Owner
      OnParameterChange = MBCDMLowAttackChange
    end
    item
      Min = 10.000000000000000000
      Max = 1000.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'Low Release'
      Units = 'ms'
      CurveFactor = 100.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 10.000000000000000000
      MinInteger = 10
      MaxInteger = 1000
      ShortLabel = 'LowRel'
      VSTModule = Owner
      OnParameterChange = MBCDMLowReleaseChange
    end
    item
      Min = -15.000000000000000000
      Max = 15.000000000000000000
      Curve = ctLinear
      DisplayName = 'Mid Gain'
      Units = 'dB'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 0.100000001490116100
      SmallStepFloat = 0.009999999776482582
      LargeStepFloat = 1.000000000000000000
      MinInteger = -15
      MaxInteger = 15
      LargeStepInteger = 2
      ShortLabel = 'MidGain'
      VSTModule = Owner
      OnParameterChange = MBCDMMidGainChange
    end
    item
      Min = -48.000000000000000000
      Max = 6.000000000000000000
      Curve = ctLinear
      DisplayName = 'Mid Threshold'
      Units = 'dB'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 0.100000001490116100
      LargeStepFloat = 3.000000000000000000
      MinInteger = -48
      MaxInteger = 6
      LargeStepInteger = 3
      ShortLabel = 'MidThrs'
      VSTModule = Owner
      OnParameterChange = MBCDMMidThresholdChange
    end
    item
      Min = 1.000000000000000000
      Max = 10.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'Mid Ratio'
      CurveFactor = 10.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 1.000000000000000000
      MinInteger = 1
      MaxInteger = 10
      LargeStepInteger = 1
      ShortLabel = 'MidRtio'
      VSTModule = Owner
      OnParameterChange = MBCDMMidRatioChange
    end
    item
      Min = 10.000000000000000000
      Max = 1000.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'Mid Attack'
      Units = 'ms'
      CurveFactor = 100.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 10.000000000000000000
      MinInteger = 10
      MaxInteger = 1000
      ShortLabel = 'MidAtt'
      VSTModule = Owner
      OnParameterChange = MBCDMMidAttackChange
    end
    item
      Min = 10.000000000000000000
      Max = 1000.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'Mid Release'
      Units = 'ms'
      CurveFactor = 100.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 10.000000000000000000
      MinInteger = 10
      MaxInteger = 1000
      ShortLabel = 'MidRel'
      VSTModule = Owner
      OnParameterChange = MBCDMMidReleaseChange
    end
    item
      Min = 20.000000000000000000
      Max = 20000.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'High Frequency'
      Units = 'Hz'
      CurveFactor = 1000.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 100.000000000000000000
      SmallStepFloat = 10.000000000000000000
      LargeStepFloat = 1000.000000000000000000
      Flags = [kVstParameterUsesFloatStep]
      MinInteger = 20
      MaxInteger = 20000
      StepInteger = 100
      LargeStepInteger = 1000
      ShortLabel = 'HighFrq'
      VSTModule = Owner
      OnParameterChange = MBCDMHighFrequencyChange
    end
    item
      Min = 1.000000000000000000
      Max = 10.000000000000000000
      Curve = ctLinear
      DisplayName = 'High Order'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 2.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 4.000000000000000000
      Flags = [kVstParameterUsesIntegerMinMax]
      MinInteger = 1
      MaxInteger = 10
      StepInteger = 2
      LargeStepInteger = 4
      ShortLabel = 'HighOrd'
      VSTModule = Owner
      OnParameterChange = MBCDCHighOrderChange
    end
    item
      Min = -15.000000000000000000
      Max = 15.000000000000000000
      Curve = ctLinear
      DisplayName = 'High Gain'
      Units = 'dB'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 0.100000001490116100
      SmallStepFloat = 0.009999999776482582
      LargeStepFloat = 1.000000000000000000
      MinInteger = -15
      MaxInteger = 15
      LargeStepInteger = 2
      ShortLabel = 'HighGai'
      VSTModule = Owner
      OnParameterChange = MBCDMHighGainChange
    end
    item
      Min = -48.000000000000000000
      Max = 6.000000000000000000
      Curve = ctLinear
      DisplayName = 'High Threshold'
      Units = 'dB'
      CurveFactor = 1.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 0.100000001490116100
      LargeStepFloat = 3.000000000000000000
      MinInteger = -48
      MaxInteger = 6
      LargeStepInteger = 3
      ShortLabel = 'HighTrh'
      VSTModule = Owner
      OnParameterChange = MBCDMHighThresholdChange
    end
    item
      Min = 1.000000000000000000
      Max = 10.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'High Ratio'
      CurveFactor = 10.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 1.000000000000000000
      MinInteger = 1
      MaxInteger = 10
      LargeStepInteger = 1
      ShortLabel = 'HiRatio'
      VSTModule = Owner
      OnParameterChange = MBCDMHighRatioChange
    end
    item
      Min = 10.000000000000000000
      Max = 1000.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'High Attack'
      Units = 'ms'
      CurveFactor = 100.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 10.000000000000000000
      MinInteger = 10
      MaxInteger = 1000
      ShortLabel = 'HighAtt'
      VSTModule = Owner
      OnParameterChange = MBCDMHighAttackChange
    end
    item
      Min = 10.000000000000000000
      Max = 1000.000000000000000000
      Curve = ctLogarithmic
      DisplayName = 'High Release'
      Units = 'ms'
      CurveFactor = 100.000000000000000000
      SmoothingFactor = 1.000000000000000000
      StepFloat = 1.000000000000000000
      SmallStepFloat = 1.000000000000000000
      LargeStepFloat = 10.000000000000000000
      MinInteger = 10
      MaxInteger = 1000
      ShortLabel = 'HighRel'
      VSTModule = Owner
      OnParameterChange = MBCDMHighReleaseChange
    end>
  OnEditOpen = VSTModuleEditOpen
  OnProcess = VSTModuleProcess
  OnProcessReplacing = VSTModuleProcess
  OnProcessDoubleReplacing = VSTModuleProcessDoubleReplacing
  Left = 218
  Top = 81
  Height = 150
  Width = 215
end
