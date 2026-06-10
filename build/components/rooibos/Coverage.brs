' @ignore
function rooibos_Coverage_reportCodeCoverage() as void
    if RBS_CC_26_reportLine("2", 2) and (m.global._rbs_ccn = invalid)
        RBS_CC_26_reportLine("2", 3)
        RBS_CC_26_reportLine("3", 1)
        ? "There was no rooibos code coverage component - not generating coverage report"
        RBS_CC_26_reportLine("4", 1)
        return
    end if
    RBS_CC_26_reportLine("6", 1)
    t = createObject("roTimespan")
    RBS_CC_26_reportLine("7", 1)
    ? ""
    RBS_CC_26_reportLine("8", 1)
    ? "...Generating code coverage report"
    RBS_CC_26_reportLine("9", 1)
    ? ""
    RBS_CC_26_reportLine("10", 1)
    m.global._rbs_ccn.save = true
    RBS_CC_26_reportLine("11", 1)
    cc = m.global._rbs_ccn
    RBS_CC_26_reportLine("12", 1)
    expectedMap = cc.expectedMap
    RBS_CC_26_reportLine("13", 1)
    filePathMap = cc.filePathMap
    RBS_CC_26_reportLine("14", 1)
    resolvedMap = cc.resolvedMap
    RBS_CC_26_reportLine("15", 1)
    hitFiles = []
    RBS_CC_26_reportLine("16", 1)
    missFiles = []
    RBS_CC_26_reportLine("17", 1)
    allLinesCount = 0
    RBS_CC_26_reportLine("18", 1)
    allLinesHit = 0
    RBS_CC_26_reportLine("19", 1): for each key in expectedMap
        RBS_CC_26_reportLine("20", 1)
        filename = filePathMap[key]
        RBS_CC_26_reportLine("21", 1)
        expectedCount = expectedMap[key].count()
        RBS_CC_26_reportLine("22", 1)
        allLinesCount += expectedCount
        if RBS_CC_26_reportLine("23", 2) and (expectedCount > 0)
            RBS_CC_26_reportLine("23", 3)
            if RBS_CC_26_reportLine("24", 2) and (resolvedMap[key] <> invalid)
                RBS_CC_26_reportLine("24", 3)
                RBS_CC_26_reportLine("25", 1)
                resolvedCount = resolvedMap[key].count()
                RBS_CC_26_reportLine("26", 1)
                allLinesHit += resolvedCount
                if RBS_CC_26_reportLine("27", 2) and (resolvedCount = 0)
                    RBS_CC_26_reportLine("27", 3)
                    RBS_CC_26_reportLine("28", 1)
                    resolvedPercent = 0
                else
                    RBS_CC_26_reportLine("29", 3)
                    RBS_CC_26_reportLine("30", 1)
                    resolvedPercent = (resolvedCount / expectedCount) * 100
                end if
                RBS_CC_26_reportLine("32", 1)
                hitFiles.push({
                    percent: resolvedPercent
                    text: filename + ": " + str(resolvedPercent).trim() + "% (" + stri(resolvedCount).trim() + "/" + stri(expectedCount).trim() + ")"
                })
            else
                RBS_CC_26_reportLine("36", 3)
                RBS_CC_26_reportLine("37", 1)
                missFiles.push(filename + ": MISS!")
            end if
        else
            RBS_CC_26_reportLine("39", 3)
            RBS_CC_26_reportLine("40", 1)
            missFiles.push(filename + ": MISS!")
        end if
    end for
    if RBS_CC_26_reportLine("43", 2) and (allLinesHit = 0)
        RBS_CC_26_reportLine("43", 3)
        RBS_CC_26_reportLine("44", 1)
        allLinesPercent = 0
    else
        RBS_CC_26_reportLine("45", 3)
        RBS_CC_26_reportLine("46", 1)
        allLinesPercent = (allLinesHit / allLinesCount) * 100
    end if
    RBS_CC_26_reportLine("48", 1)
    ? ""
    RBS_CC_26_reportLine("49", 1)
    ? ""
    RBS_CC_26_reportLine("50", 1)
    ? "+++++++++++++++++++++++++++++++++++++++++++"
    RBS_CC_26_reportLine("51", 1)
    ? "Code Coverage Report"
    RBS_CC_26_reportLine("52", 1)
    ? "+++++++++++++++++++++++++++++++++++++++++++"
    RBS_CC_26_reportLine("53", 1)
    ? ""
    RBS_CC_26_reportLine("54", 1)
    ? "Total Coverage: "; str(allLinesPercent).trim(); "% ("; stri(allLinesHit).trim(); "/" + stri(allLinesCount).trim(); ")"
    RBS_CC_26_reportLine("55", 1)
    ? "Files: "; resolvedMap.count(); "/"; expectedMap.count()
    RBS_CC_26_reportLine("56", 1)
    ? ""
    RBS_CC_26_reportLine("57", 1)
    ? "HIT FILES"
    RBS_CC_26_reportLine("58", 1)
    ? "---------"
    RBS_CC_26_reportLine("59", 1)
    hitFiles.SortBy("percent")
    RBS_CC_26_reportLine("60", 1): for i = 0 to hitFiles.count() - 1
        RBS_CC_26_reportLine("61", 1)
        ? hitFiles[i].text
    end for
    RBS_CC_26_reportLine("63", 1)
    ? ""
    RBS_CC_26_reportLine("64", 1)
    ? "MISSED FILES"
    RBS_CC_26_reportLine("65", 1)
    ? "------------"
    RBS_CC_26_reportLine("66", 1): for i = 0 to missFiles.count() - 1
        RBS_CC_26_reportLine("67", 1)
        ? missFiles[i]
    end for
    RBS_CC_26_reportLine("69", 1)
    ? ""
    RBS_CC_26_reportLine("70", 1)
    ? "+++++++++++++++++++++++++++++++++++++++++++"
    RBS_CC_26_reportLine("71", 1)
    ? "Code Coverage Report Complete"; t.totalMilliseconds(); "ms"
    RBS_CC_26_reportLine("72", 1)
    ? "+++++++++++++++++++++++++++++++++++++++++++"
end function

function rooibos_Coverage_createLCovOutput(logToConsole = true as boolean)
    RBS_CC_26_reportLine("76", 1)
    ? "Generating lcov.info file..."
    RBS_CC_26_reportLine("77", 1)
    cc = m.global._rbs_ccn
    RBS_CC_26_reportLine("78", 1)
    expectedMap = cc.expectedMap
    RBS_CC_26_reportLine("79", 1)
    filePathMap = cc.filePathMap
    RBS_CC_26_reportLine("80", 1)
    resolvedMap = cc.resolvedMap
    RBS_CC_26_reportLine("81", 1)
    results = []
    RBS_CC_26_reportLine("82", 1): for each module in filePathMap.items()
        RBS_CC_26_reportLine("83", 1)
        buffer = ""
        RBS_CC_26_reportLine("84", 1)
        moduleNumber = module.key
        RBS_CC_26_reportLine("85", 1)
        filePath = module.value
        RBS_CC_26_reportLine("86", 1)
        packageName = "."
        RBS_CC_26_reportLine("87", 1)
        relativePath = filePath.replace("pkg:", packageName)
        RBS_CC_26_reportLine("88", 1)
        sanitizedPath = relativePath.replace("\\", "/")
        RBS_CC_26_reportLine("89", 1)
        buffer += "TN:" + chr(10)
        RBS_CC_26_reportLine("90", 1)
        buffer += "SF:" + sanitizedPath + chr(10)
        RBS_CC_26_reportLine("91", 1): for each expected in expectedMap[moduleNumber]
            RBS_CC_26_reportLine("92", 1)
            lineNumber = val(expected)
            RBS_CC_26_reportLine("93", 1)
            SHIFT = 1
            if RBS_CC_26_reportLine("94", 2) and (resolvedMap[moduleNumber] <> invalid and resolvedMap[moduleNumber].doesExist(expected))
                RBS_CC_26_reportLine("94", 3)
                RBS_CC_26_reportLine("95", 1)
                buffer += "DA:" + str(lineNumber + SHIFT).trim() + "," + str(resolvedMap[moduleNumber][expected]).trim() + chr(10)
            else
                RBS_CC_26_reportLine("96", 3)
                RBS_CC_26_reportLine("97", 1)
                buffer += "DA:" + str(lineNumber + SHIFT).trim() + ",0" + chr(10)
            end if
        end for
        RBS_CC_26_reportLine("100", 1)
        buffer += "LF:" + str(expectedMap[moduleNumber].count()).trim() + chr(10)
        if RBS_CC_26_reportLine("101", 2) and (resolvedMap[moduleNumber] <> invalid)
            RBS_CC_26_reportLine("101", 3)
            RBS_CC_26_reportLine("102", 1)
            buffer += "LH:" + str(resolvedMap[moduleNumber].count()).trim() + chr(10)
        else
            RBS_CC_26_reportLine("103", 3)
            RBS_CC_26_reportLine("104", 1)
            buffer += "LH:0" + chr(10)
        end if
        RBS_CC_26_reportLine("106", 1)
        buffer += "end_of_record"
        if RBS_CC_26_reportLine("107", 2) and (logToConsole)
            RBS_CC_26_reportLine("107", 3)
            RBS_CC_26_reportLine("108", 1)
            ? buffer
            ' When logging to the console it is very possible to flood the buffer and cause the application to exit.
            ' Sleep for a short amount of time so as to give console scrapers time to empty the buffer
            RBS_CC_26_reportLine("111", 1)
            sleep(30)
        else
            RBS_CC_26_reportLine("112", 3)
            RBS_CC_26_reportLine("113", 1)
            results.push(buffer)
        end if
    end for
    RBS_CC_26_reportLine("116", 1)
    return results.join(chr(10))
end function

function rooibos_Coverage_printLCovInfo()
    RBS_CC_26_reportLine("120", 1)
    ? ""
    RBS_CC_26_reportLine("121", 1)
    ? "+++++++++++++++++++++++++++++++++++++++++++"
    RBS_CC_26_reportLine("122", 1)
    ? "LCOV.INFO FILE"
    RBS_CC_26_reportLine("123", 1)
    ? "+++++++++++++++++++++++++++++++++++++++++++"
    RBS_CC_26_reportLine("124", 1)
    ? ""
    RBS_CC_26_reportLine("125", 1)
    ? "+-=-coverage:start"
    RBS_CC_26_reportLine("126", 1)
    rooibos_coverage_createLCovOutput()
    RBS_CC_26_reportLine("127", 1)
    ? "+-=-coverage:end"
end function

'//# sourceMappingURL=./Coverage.brs.map
function RBS_CC_26_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "26"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "26"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./Coverage.brs.map