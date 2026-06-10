function WatchLaterModel() as Object
    RBS_CC_4_reportLine("2", 1)
    model = {}
    RBS_CC_4_reportLine("3", 1)
    model.toggleWatchLater = function(content as Object, watchLaterList as Object) as Object
        RBS_CC_4_reportLine("5", 1)
        item = {
            title: content.ShortDescriptionLine1
            description: content.ShortDescriptionLine2
            url: content.url
            poster: content.HDPosterUrl
        }
        RBS_CC_4_reportLine("12", 1): for i = 0 to watchLaterList.count() - 1
            if RBS_CC_4_reportLine("13", 2) and (watchLaterList[i].title = item.title)
                RBS_CC_4_reportLine("13", 3)
                RBS_CC_4_reportLine("14", 1)
                watchLaterList.delete(i)
                RBS_CC_4_reportLine("16", 1)
                return {
                    added: false
                    updatedList: watchLaterList
                }
            end if
        end for
        RBS_CC_4_reportLine("22", 1)
        watchLaterList.push(item)
        RBS_CC_4_reportLine("24", 1)
        return {
            added: true
            updatedList: watchLaterList
        }
    end function
    RBS_CC_4_reportLine("29", 1)
    return model
end function

function RBS_CC_4_reportLine(lineNumber, reportType = 1)
    _rbs_ccn = m._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "4"
            "l": lineNumber
            "r": reportType
        }
        return true
    end if
    _rbs_ccn = m?.global?._rbs_ccn
    if _rbs_ccn <> invalid
        _rbs_ccn.entry = {
            "f": "4"
            "l": lineNumber
            "r": reportType
        }
        m._rbs_ccn = _rbs_ccn
        return true
    end if
    return true
end function
'//# sourceMappingURL=./WatchLaterModel.brs.map