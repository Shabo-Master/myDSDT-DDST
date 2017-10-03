/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20161210-64(RM)
 * Copyright (c) 2000 - 2016 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of SSDT-8.aml, Tue Oct  3 13:20:15 2017
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000001F9 (505)
 *     Revision         0x02
 *     Checksum         0x2C
 *     OEM ID           "SgRef"
 *     OEM Table ID     "SgPeg"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120913 (538052883)
 */
DefinitionBlock ("", "SSDT", 2, "SgRef", "SgPeg", 0x00001000)
{
    /*
     * External declarations were imported from
     * a reference file -- refs.txt
     */

    External (_GPE.MMTB, MethodObj)    // Imported: 0 Arguments
    External (_GPE.VHOV, MethodObj)    // Imported: 3 Arguments
    External (_SB_.PCI0.GFX0.DD02._BCM, MethodObj)    // Imported: 1 Arguments
    External (_SB_.PCI0.LPCB.H_EC.ECMD, MethodObj)    // Imported: 1 Arguments
    External (_SB_.PCI0.LPCB.H_EC.ECRD, MethodObj)    // Imported: 1 Arguments
    External (_SB_.PCI0.LPCB.H_EC.ECWT, MethodObj)    // Imported: 2 Arguments
    External (_SB_.PCI0.PEG0.PEGP, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP.PVID, FieldUnitObj)
    External (_SB_.PCI0.PEG0.PEGP.SGPO, MethodObj)    // Imported: 2 Arguments
    External (_SB_.PCI0.PGOF, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.PGON, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.SAT0.SDSM, MethodObj)    // Imported: 4 Arguments
    External (_SB_.PCI0.XHC_.RHUB.TPLD, MethodObj)    // Imported: 2 Arguments
    External (GBAS, FieldUnitObj)
    External (MDBG, MethodObj)    // Imported: 1 Arguments
    External (PWOK, FieldUnitObj)
    External (SGGP, FieldUnitObj)
    External (SGMD, FieldUnitObj)

    Scope (\_SB.PCI0.PEG0.PEGP)
    {
        Method (SGON, 0, Serialized)
        {
            \_SB.PCI0.PGON (One)
            Return (Zero)
        }

        Method (SGOF, 0, Serialized)
        {
            \_SB.PCI0.PGOF (One)
            Return (Zero)
        }

        Method (SGST, 0, Serialized)
        {
            If (And (SGMD, 0x0F))
            {
                If (LNotEqual (SGGP, One))
                {
                    Return (0x0F)
                }

                If (LEqual (SGPI (PWOK), One))
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            If (LNotEqual (PVID, 0xFFFF))
            {
                Return (0x0F)
            }

            Return (Zero)
        }

        Method (SGPI, 1, Serialized)
        {
            Store (Zero, Local2)
            If (And (SGMD, 0x0F))
            {
                If (LEqual (SGGP, One))
                {
                    ShiftRight (Arg0, 0x07, Local7)
                    And (Local7, One, Local7)
                    And (Arg0, 0x7F, Local6)
                    If (LLess (Local6, 0x20))
                    {
                        Store (0x0C, Local5)
                        Store (Local6, Local4)
                    }
                    ElseIf (LLess (Local6, 0x40))
                    {
                        Store (0x38, Local5)
                        Store (Subtract (Local6, 0x20), Local4)
                    }
                    Else
                    {
                        Store (0x48, Local5)
                        Store (Subtract (Local6, 0x40), Local4)
                    }

                    If (LLessEqual (And (Arg0, 0x7F), 0x4B))
                    {
                        Store (Add (\GBAS, Local5), Local3)
                        OperationRegion (LGPI, SystemIO, Local3, 0x04)
                        Field (LGPI, ByteAcc, NoLock, Preserve)
                        {
                            TEMP,   32
                        }

                        Store (TEMP, Local2)
                    }

                    ShiftRight (Local2, Local4, Local2)
                    If (LEqual (Local7, Zero))
                    {
                        Not (Local2, Local2)
                    }

                    And (Local2, One, Local2)
                }
            }

            Return (Local2)
        }

        Method (SGPO, 2, Serialized)
        {
            Store (Arg1, Local2)
            If (And (SGMD, 0x0F))
            {
                If (LEqual (SGGP, One))
                {
                    ShiftRight (Arg0, 0x07, Local7)
                    And (Local7, One, Local7)
                    And (Arg0, 0x7F, Local6)
                    If (LLess (Local6, 0x20))
                    {
                        Store (0x0C, Local5)
                        Store (Local6, Local4)
                    }
                    ElseIf (LLess (Local6, 0x40))
                    {
                        Store (0x38, Local5)
                        Store (Subtract (Local6, 0x20), Local4)
                    }
                    Else
                    {
                        Store (0x48, Local5)
                        Store (Subtract (Local6, 0x40), Local4)
                    }

                    If (LEqual (Local7, Zero))
                    {
                        Not (Local2, Local2)
                    }

                    And (Local2, One, Local2)
                    If (LLessEqual (And (Arg0, 0x7F), 0x4B))
                    {
                        Store (Add (\GBAS, Local5), Local3)
                        OperationRegion (LGPI, SystemIO, Local3, 0x04)
                        Field (LGPI, ByteAcc, NoLock, Preserve)
                        {
                            TEMP,   32
                        }

                        Store (TEMP, Local1)
                        ShiftLeft (Local2, Local4, Local2)
                        ShiftLeft (One, Local4, Local0)
                        And (Local1, Not (Local0), Local1)
                        Or (Local1, Local2, Local1)
                        Store (Local1, TEMP)
                    }
                }
            }
        }
    }
}

