'import "pkg:/source/tests/BaseTestSuite.spec.bs"
' bs:disable-next-line: 
function __tests_HomeScreen2Tests_builder()
    instance = __tests_BaseTestSuite_builder()
    instance.super1_new = instance.new
    instance.new = sub()
        m.super1_new()
    end sub
    instance._ = function()
        m.assertTrue(true)
    end function
    return instance
end function
function tests_HomeScreen2Tests()
    instance = __tests_HomeScreen2Tests_builder()
    instance.new()
    return instance
end function
'//# sourceMappingURL=./HomeScreenTest.spec.brs.map