/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20161210-64(RM)
 * Copyright (c) 2000 - 2016 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of SSDT-3.aml, Tue Oct  3 13:20:15 2017
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000004E5 (1253)
 *     Revision         0x02
 *     Checksum         0x6E
 *     OEM ID           "Ther_R"
 *     OEM Table ID     "Ther_Rvp"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("", "SSDT", 2, "Ther_R", "Ther_Rvp", 0x00001000)
{
    /*
     * External declarations were imported from
     * a reference file -- refs.txt
     */

    External (_GPE.MMTB, MethodObj)    // Imported: 0 Arguments
    External (_GPE.VHOV, MethodObj)    // Imported: 3 Arguments
    External (_PR_.ACRT, FieldUnitObj)
    External (_PR_.APSV, FieldUnitObj)
    External (_PR_.CPU0, ProcessorObj)
    External (_PR_.CPU1, ProcessorObj)
    External (_PR_.CPU2, ProcessorObj)
    External (_PR_.CPU3, ProcessorObj)
    External (_PR_.CPU4, ProcessorObj)
    External (_PR_.CPU5, ProcessorObj)
    External (_PR_.CPU6, ProcessorObj)
    External (_PR_.CPU7, ProcessorObj)
    External (_PR_.DTS1, FieldUnitObj)
    External (_PR_.DTS2, FieldUnitObj)
    External (_PR_.DTS3, FieldUnitObj)
    External (_PR_.DTS4, FieldUnitObj)
    External (_PR_.DTSE, FieldUnitObj)
    External (_PR_.PDTS, FieldUnitObj)
    External (_PR_.PKGA, FieldUnitObj)
    External (_SB_.PCI0.GFX0.DD02._BCM, MethodObj)    // Imported: 1 Arguments
    External (_SB_.PCI0.LPCB.H_EC.ECMD, MethodObj)    // Imported: 1 Arguments
    External (_SB_.PCI0.LPCB.H_EC.ECRD, MethodObj)    // Imported: 1 Arguments
    External (_SB_.PCI0.LPCB.H_EC.ECWT, MethodObj)    // Imported: 2 Arguments
    External (_SB_.PCI0.LPCB.H_EC.PENV, IntObj)
    External (_SB_.PCI0.PEG0.PEGP.SGPO, MethodObj)    // Imported: 2 Arguments
    External (_SB_.PCI0.SAT0.SDSM, MethodObj)    // Imported: 4 Arguments
    External (_SB_.PCI0.XHC_.RHUB.TPLD, MethodObj)    // Imported: 2 Arguments
    External (AC0F, FieldUnitObj)
    External (AC1F, FieldUnitObj)
    External (CRTT, FieldUnitObj)
    External (CTYP, FieldUnitObj)
    External (ECON, FieldUnitObj)
    External (MDBG, MethodObj)    // Imported: 1 Arguments
    External (PSVT, FieldUnitObj)
    External (TC1V, FieldUnitObj)
    External (TC2V, FieldUnitObj)
    External (TCNT, FieldUnitObj)
    External (TSPV, FieldUnitObj)
    External (VFN0, FieldUnitObj)
    External (VFN1, FieldUnitObj)

    Scope (\_TZ)
    {
        Name (ETMD, One)
        Method (FOFF, 0, Serialized)
        {
        }

        PowerResource (FN00, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Return (VFN0)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Store (One, VFN0)
                If (LAnd (ECON, ETMD))
                {
                    \_SB.PCI0.LPCB.H_EC.ECWT (AC0F, RefOf (\_SB.PCI0.LPCB.H_EC.PENV))
                    \_SB.PCI0.LPCB.H_EC.ECMD (0x1A)
                }
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Store (Zero, VFN0)
                If (LAnd (ECON, ETMD))
                {
                    If (LNotEqual (VFN1, Zero))
                    {
                        \_SB.PCI0.LPCB.H_EC.ECWT (AC1F, RefOf (\_SB.PCI0.LPCB.H_EC.PENV))
                    }
                    Else
                    {
                        \_SB.PCI0.LPCB.H_EC.ECWT (Zero, RefOf (\_SB.PCI0.LPCB.H_EC.PENV))
                    }

                    \_SB.PCI0.LPCB.H_EC.ECMD (0x1A)
                }
            }
        }

        ThermalZone (TZ00)
        {
            Name (PTMP, 0x0BB8)
            Method (_SCP, 1, Serialized)  // _SCP: Set Cooling Policy
            {
                Store (Arg0, CTYP)
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                If (CondRefOf (\_PR.ACRT))
                {
                    If (LNotEqual (\_PR.ACRT, Zero))
                    {
                        Return (Add (0x0AAC, Multiply (\_PR.ACRT, 0x0A)))
                    }
                }

                Return (Add (0x0AAC, Multiply (CRTT, 0x0A)))
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                If (LNot (ETMD))
                {
                    Return (0x0BB8)
                }

                If (LEqual (\_PR.DTSE, 0x03))
                {
                    Return (Add (0x0B10, Multiply (CRTT, 0x0A)))
                }

                If (LEqual (\_PR.DTSE, One))
                {
                    If (LEqual (\_PR.PKGA, One))
                    {
                        Store (\_PR.PDTS, Local0)
                        Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
                    }

                    Store (\_PR.DTS1, Local0)
                    If (LGreater (\_PR.DTS2, Local0))
                    {
                        Store (\_PR.DTS2, Local0)
                    }

                    If (LGreater (\_PR.DTS3, Local0))
                    {
                        Store (\_PR.DTS3, Local0)
                    }

                    If (LGreater (\_PR.DTS4, Local0))
                    {
                        Store (\_PR.DTS4, Local0)
                    }

                    Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
                }

                Return (0x0BC2)
            }
        }

        ThermalZone (TZ01)
        {
            Name (PTMP, 0x0BB8)
            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                If (CondRefOf (\_PR.ACRT))
                {
                    If (LNotEqual (\_PR.ACRT, Zero))
                    {
                        Return (Add (0x0AAC, Multiply (\_PR.ACRT, 0x0A)))
                    }
                }

                Return (Add (0x0AAC, Multiply (CRTT, 0x0A)))
            }

            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                If (LNot (ETMD))
                {
                    Return (0x0BCC)
                }

                If (LEqual (\_PR.DTSE, 0x03))
                {
                    Return (Add (0x0B10, Multiply (CRTT, 0x0A)))
                }

                If (LEqual (\_PR.DTSE, One))
                {
                    If (LEqual (\_PR.PKGA, One))
                    {
                        Store (\_PR.PDTS, Local0)
                        Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
                    }

                    Store (\_PR.DTS1, Local0)
                    If (LGreater (\_PR.DTS2, Local0))
                    {
                        Store (\_PR.DTS2, Local0)
                    }

                    If (LGreater (\_PR.DTS3, Local0))
                    {
                        Store (\_PR.DTS3, Local0)
                    }

                    If (LGreater (\_PR.DTS4, Local0))
                    {
                        Store (\_PR.DTS4, Local0)
                    }

                    Return (Add (0x0AAC, Multiply (Local0, 0x0A)))
                }

                Return (0x0BD6)
            }

            Method (_PSL, 0, Serialized)  // _PSL: Passive List
            {
                If (LEqual (TCNT, 0x08))
                {
                    Return (Package (0x08)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1, 
                        \_PR.CPU2, 
                        \_PR.CPU3, 
                        \_PR.CPU4, 
                        \_PR.CPU5, 
                        \_PR.CPU6, 
                        \_PR.CPU7
                    })
                }

                If (LEqual (TCNT, 0x04))
                {
                    Return (Package (0x04)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1, 
                        \_PR.CPU2, 
                        \_PR.CPU3
                    })
                }

                If (LEqual (TCNT, 0x02))
                {
                    Return (Package (0x02)
                    {
                        \_PR.CPU0, 
                        \_PR.CPU1
                    })
                }

                Return (Package (0x01)
                {
                    \_PR.CPU0
                })
            }

            Method (_PSV, 0, Serialized)  // _PSV: Passive Temperature
            {
                If (CondRefOf (\_PR.APSV))
                {
                    If (LNotEqual (\_PR.APSV, Zero))
                    {
                        Return (Add (0x0AAC, Multiply (\_PR.APSV, 0x0A)))
                    }
                }

                Return (Add (0x0AAC, Multiply (PSVT, 0x0A)))
            }

            Method (_TC1, 0, Serialized)  // _TC1: Thermal Constant 1
            {
                Return (TC1V)
            }

            Method (_TC2, 0, Serialized)  // _TC2: Thermal Constant 2
            {
                Return (TC2V)
            }

            Method (_TSP, 0, Serialized)  // _TSP: Thermal Sampling Period
            {
                Return (TSPV)
            }
        }
    }
}

