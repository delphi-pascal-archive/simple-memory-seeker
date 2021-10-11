object Form1: TForm1
  Left = 215
  Top = 134
  Width = 796
  Height = 599
  Caption = 'Memory Seeker by SVSD_VAL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 788
    Height = 571
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = 'Memory Seek'
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 44
        Width = 247
        Height = 496
        Align = alLeft
        TabOrder = 0
        object ListBox2: TListBox
          Left = 1
          Top = 149
          Width = 245
          Height = 346
          Align = alClient
          ItemHeight = 16
          TabOrder = 0
          OnDblClick = ListBox2DblClick
        end
        object Panel2: TPanel
          Left = 1
          Top = 1
          Width = 245
          Height = 148
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label1: TLabel
            Left = 10
            Top = 98
            Width = 55
            Height = 16
            Caption = 'Finded: 0'
          end
          object Label5: TLabel
            Left = 10
            Top = 10
            Width = 65
            Height = 16
            Caption = 'Find value:'
          end
          object Edit1: TEdit
            Left = 10
            Top = 30
            Width = 100
            Height = 21
            TabOrder = 0
            Text = '223725915'
          end
          object FindButton1: TButton
            Left = 10
            Top = 58
            Width = 80
            Height = 31
            Caption = 'Find'
            TabOrder = 1
            OnClick = FindButton1Click
          end
          object SieveButton2: TButton
            Left = 146
            Top = 58
            Width = 87
            Height = 31
            Caption = 'Sort(Sieve)'
            TabOrder = 2
            OnClick = SieveButton2Click
          end
          object ProgressBar1: TProgressBar
            Left = 10
            Top = 119
            Width = 228
            Height = 21
            TabOrder = 3
          end
          object FindByteType: TComboBox
            Left = 116
            Top = 30
            Width = 119
            Height = 22
            Style = csOwnerDrawFixed
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 16
            ItemIndex = 2
            ParentFont = False
            TabOrder = 4
            Text = '4Byte'
            Items.Strings = (
              '1Byte'
              '2Byte'
              '4Byte')
          end
          object AddToList: TCheckBox
            Left = 148
            Top = 98
            Width = 90
            Height = 21
            Hint = 'Show in list adreses after Find'
            Caption = 'ShowInList'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
          end
        end
      end
      object Panel3: TPanel
        Left = 247
        Top = 44
        Width = 533
        Height = 496
        Align = alClient
        TabOrder = 1
        object GroupBox1: TGroupBox
          Left = 1
          Top = 1
          Width = 531
          Height = 72
          Align = alTop
          Caption = ' Set or read memory at address '
          TabOrder = 0
          object Label2: TLabel
            Left = 10
            Top = 20
            Width = 51
            Height = 16
            Caption = 'Address'
          end
          object Label3: TLabel
            Left = 128
            Top = 20
            Width = 35
            Height = 16
            Caption = 'Value'
          end
          object Label4: TLabel
            Left = 246
            Top = 17
            Width = 276
            Height = 16
            Caption = 'Insert/Delete (add or remove address from list)'
          end
          object AddressEdit: TEdit
            Left = 10
            Top = 39
            Width = 109
            Height = 21
            TabOrder = 0
          end
          object ValueEdit: TEdit
            Left = 128
            Top = 39
            Width = 90
            Height = 21
            TabOrder = 1
          end
          object SetButton3: TButton
            Left = 364
            Top = 39
            Width = 70
            Height = 26
            Caption = 'Set'
            TabOrder = 2
            OnClick = SetButton3Click
          end
          object ReadButton4: TButton
            Left = 449
            Top = 39
            Width = 73
            Height = 26
            Caption = 'Read'
            TabOrder = 3
            OnClick = ReadButton4Click
          end
          object ByteBox: TComboBox
            Left = 226
            Top = 39
            Width = 120
            Height = 22
            Style = csOwnerDrawFixed
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 16
            ItemIndex = 2
            ParentFont = False
            TabOrder = 4
            Text = '4Byte'
            Items.Strings = (
              '1Byte'
              '2Byte'
              '4Byte')
          end
        end
        object ListBox3: TListBox
          Left = 1
          Top = 73
          Width = 531
          Height = 422
          Align = alClient
          ItemHeight = 16
          TabOrder = 1
          OnClick = ListBox3Click
          OnKeyDown = ListBox3KeyDown
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 780
        Height = 44
        Align = alTop
        TabOrder = 2
        DesignSize = (
          780
          44)
        object ProcessBox: TComboBox
          Left = 8
          Top = 10
          Width = 761
          Height = 24
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 16
          TabOrder = 0
          OnDropDown = ProcessBoxDropDown
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'About'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 780
        Height = 540
        Align = alClient
        BorderStyle = bsNone
        Color = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Lines.Strings = (
          'Simple memory seeker'
          'By SVSD_VAL'
          'Site   : http://svsd.MirGames.Ru'
          'ICq    : 223-725-915'
          'Mail   : valdim_05@mail.ru / svsd_val@SibNet.ru'
          'Jabber : svsd_val@Jabber.Sibnet.ru'
          '-------------------------------------------'
          'Example: '
          '1: The game looked amount of ammunition '
          '2: write the number of Hit '#39'Find'#39' '
          '3: Going into the game shooting a second store '
          '4: write the number of Hit '#39'Sort'#39' '
          '5: Repetitive 3-4 until a few links from 1 to 4'
          '6: Add it to the list by double clicking on it '
          
            '7: Hit it in the top of '#39'Value'#39' write something that would like ' +
            'to see in the game and Hit '
          #39'Set'#39
          ''
          #1055#1088#1080#1084#1077#1088' :'
          '1: '#1074' '#1080#1075#1088#1077' '#1089#1084#1086#1090#1088#1080#1084' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1072#1090#1088#1086#1085#1086#1074
          '2: '#1087#1080#1096#1077#1084' '#1080#1093' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1078#1084#1105#1084' '#39'Find'#39
          '3: '#1087#1077#1088#1077#1093#1086#1076#1080#1084' '#1074' '#1080#1075#1088#1091' '#1089#1090#1088#1077#1083#1103#1077#1084' '#1074#1090#1086#1088#1086#1081' '#1088#1072#1079' '#1079#1072#1087#1086#1084#1080#1085#1072#1077#1084
          '4: '#1087#1080#1096#1077#1084' '#1080#1093' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1074' '#1078#1084#1105#1084' '#39'Sort'#39
          
            '5: '#1087#1086#1074#1090#1086#1088#1103#1077#1084' '#1087#1091#1085#1082#1090' 3-4 '#1076#1086' '#1090#1077#1093' '#1087#1086#1088' '#1087#1086#1082#1072' '#1085#1077' '#1087#1086#1103#1074#1080#1090#1089#1103' '#1085#1077#1084#1085#1086#1075#1086' '#1089#1089#1099#1083#1086 +
            #1082' '#1086#1090' 1 '#1076#1086' 4 '
          '('#1093#1086#1090#1103' '#1084#1086#1078#1085#1086' '#1089#1090#1088#1072#1079#1091' '#1074#1099#1073#1088#1072#1090#1100' '#1085#1077' '#1086#1090#1089#1077#1080#1074#1072#1103' '#1089#1089#1099#1083#1082#1080
          '6: '#1044#1086#1073#1072#1074#1083#1103#1077#1084' '#1077#1105' '#1074' '#1089#1087#1080#1089#1086#1082' '#1076#1074#1086#1081#1085#1099#1084' '#1082#1083#1080#1082#1086#1084' '#1087#1086' '#1085#1077#1081
          
            '7: '#1078#1084#1105#1084' '#1085#1072' '#1085#1077#1105' '#1080' '#1074' '#1074#1077#1088#1093#1091' '#1074' '#39'Value'#39' '#1087#1080#1096#1077#1084' '#1090#1086' '#1095#1090#1086' '#1093#1086#1090#1077#1083#1080' '#1073#1099' '#1091#1074#1080#1076#1077#1090 +
            #1100' '#1074' '#1080#1075#1088#1077' '#1080' '
          #1078#1084#1105#1084' '#39'Set'#39)
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object Timer1: TTimer
    Interval = 250
    OnTimer = Timer1Timer
    Left = 21
    Top = 5
  end
end
