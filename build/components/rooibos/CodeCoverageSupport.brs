' @ignore
function RBS_ReportCodeCoverage() as void
    if RBS_CC_23_reportLine("3", 2) and (m.global._rbs_ccn = invalid)
        RBS_CC_23_reportLine("3", 3)
        RBS_CC_23_reportLine("4", 1)
        ? "There was no rooibos code coverage component - not generating coverage report"
        RBS_CC_23_reportLine("5", 1)
        return
    end if
    RBS_CC_23_reportLine("7", 1)
    ? ""
    RBS_CC_23_reportLine("8", 1)
    ? "...Generating code coverage report"
    RBS_CC_23_reportLine("9", 1)
    ? ""
    RBS_CC_23_reportLine("10", 1)
    m.global._rbs_ccn.save = true
    RBS_CC_23_reportLine("11", 1)
    cc = m.global._rbs_ccn
    RBS_CC_23_reportLine("12", 1)
    hitFiles = []
    RBS_CC_23_reportLine("13", 1)
    missFiles = []
    RBS_CC_23_reportLine("14", 1)
    allLinesCount = 0
    RBS_CC_23_reportLine("15", 1)
    allLinesHit = 0
    RBS_CC_23_reportLine("16", 1): for each key in cc.expectedMap
        RBS_CC_23_reportLine("17", 1)
        filename = cc.filePathMap[key]
        RBS_CC_23_reportLine("18", 1)
        expectedCount = cc.expectedMap[key].count()
        RBS_CC_23_reportLine("19", 1)
        allLinesCount += expectedCount
        if RBS_CC_23_reportLine("20", 2) and (expectedCount > 0)
            RBS_CC_23_reportLine("20", 3)
            if RBS_CC_23_reportLine("21", 2) and (cc.resolvedMap[key] <> invalid)
                RBS_CC_23_reportLine("21", 3)
                RBS_CC_23_reportLine("22", 1)
                resolvedCount = cc.resolvedMap[key].count()
                RBS_CC_23_reportLine("23", 1)
                allLinesHit += resolvedCount
                RBS_CC_23_reportLine("24", 1)
                resolvedPercent = (resolvedCount / expectedCount) * 100
                RBS_CC_23_reportLine("25", 1)
                hitFiles.push({
                    percent: resolvedPercent
                    text: filename + ": " + str(resolvedPercent).trim() + "% (" + stri(resolvedCount).trim() + "/" + stri(expectedCount).trim() + ")"
                })
            else
                RBS_CC_23_reportLine("26", 3)
                RBS_CC_23_reportLine("27", 1)
                missFiles.push(filename + ": MISS!")
            end if
        end if
    end for
    RBS_CC_23_reportLine("31", 1)
    allLinesPercent = (allLinesHit / allLinesCount) * 100
    RBS_CC_23_reportLine("32", 1)
    ? ""
    RBS_CC_23_reportLine("33", 1)
    ? ""
    RBS_CC_23_reportLine("34", 1)
    ? "+++++++++++++++++++++++++++++++++++++++++++"
    RBS_CC_23_reportLine("35", 1)
    ? "Code Coverage Report"
    RBS_CC_23_reportLine("36", 1)
    ? "+++++++++++++++++++++++++++++++++++++++++++"
    RBS_CC_23_reportLine("37", 1)
    ? ""
    RBS_CC_23_reportLine("38", 1)
    ? "Total Coverage: "; str(allLinesPercent).trim(); "% ("; stri(allLinesHit).trim(); "/" + stri(allLinesCount).trim(); ")"
    RBS_CC_23_reportLine("39", 1)
    ? "Files: "; cc.resolvedMap.count(); "/"; cc.expectedMap.count()
    RBS_CC_23_reportLine("40", 1)
    ? ""
    RBS_CC_23_reportLine("41", 1)
    ? "HIT FILES"
    RBS_CC_23_reportLine("42", 1)
    ? "---------"
    RBS_CC_23_reportLine("43", 1)
    hitFiles.SortBy("percent")
    RBS_CC_23_reportLine("44", 1): for i = 0 to hitFiles.count() - 1
        RBS_CC_23_reportLine("45", 1)
        ? hitFiles[i].text
    end for
    RBS_CC_23_reportLine("47", 1)
    ? ""
    RBS_CC_23_reportLine("48", 1)
    ? "MISSED FILES"
    RBS_CC_23_reportLine("49", 1)
    ? "------------"
    RBS_CC_23_reportLine("50", 1): for i = 0 to missFiles.count() - 1
        RBS_CC_23_reportLine("51", 1)
        ? missFiles[i]
    end for
end function

'//# sourceMappingURL=./CodeCoverageSupport.brs.map
function RBS_CC_23_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "23"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "23"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./CodeCoverageSupport.brs.map