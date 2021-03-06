object FmAbout: TFmAbout
  Left = 370
  Top = 241
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 314
  ClientWidth = 225
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object LbTitle: TLabel
    Left = 48
    Top = 16
    Width = 121
    Height = 14
    Caption = 'Tobybear MiniHost 1.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LbCopyright: TLabel
    Left = 15
    Top = 184
    Width = 189
    Height = 42
    Alignment = taCenter
    Caption = 
      '(C)opyright in 2004 by Tobias Fleischer'#13#10'based on the Delphi VST' +
      ' and ASIO '#13#10'host code by Christian Budde'
  end
  object LbMail: TLabel
    Left = 40
    Top = 160
    Width = 101
    Height = 14
    Cursor = crHandPoint
    Caption = 'tobybear@web.de'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = LbMailClick
  end
  object LbWeb: TLabel
    Left = 40
    Top = 144
    Width = 130
    Height = 14
    Cursor = crHandPoint
    Caption = 'http://www.tobybear.de'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = LbWebClick
  end
  object LbDonate: TLabel
    Left = 24
    Top = 120
    Width = 175
    Height = 14
    Cursor = crHandPoint
    Caption = '[Click here to donate via PayPal]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = LbDonateClick
  end
  object Lbml: TLabel
    Left = 8
    Top = 160
    Width = 27
    Height = 14
    Caption = 'email:'
  end
  object LbTrademarks: TLabel
    Left = 40
    Top = 240
    Width = 150
    Height = 28
    Alignment = taCenter
    Caption = 'VST and ASIO are registered '#13#10'trademarks by Steinberg GmbH'
  end
  object LbHours: TLabel
    Left = 8
    Top = 64
    Width = 203
    Height = 42
    Alignment = taCenter
    Caption = 
      'Countless hours of coding were needed'#13#10'to make this little appli' +
      'cation, so please '#13#10'donate some money if you use it regularly!'
  end
  object LbReadManual: TLabel
    Left = 8
    Top = 36
    Width = 203
    Height = 14
    Caption = 'Read the included manual for detailed help'
  end
  object LbWb: TLabel
    Left = 8
    Top = 144
    Width = 25
    Height = 14
    Caption = 'web:'
  end
  object BtOK: TButton
    Left = 72
    Top = 280
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = BtOKClick
  end
end
