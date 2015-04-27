import Quick
import Nimble
import butterfly

class UtilsSpec: QuickSpec {
    override func spec() {
        it("Trims whitespace correctly.") {
            let original = " \t lotsofwhitespace   "
            let result = Utils.trimWhitespaceFromText(original)
            expect(result).to(equal("lotsofwhitespace"))
        }
    }
}
