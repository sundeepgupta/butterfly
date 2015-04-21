import Quick
import Nimble
import butterfly

class MemorySpec: QuickSpec {
    override func spec() {
        it("Serializes correctly") {
            let subject = Memory(thoughts: "some thoughts")
            let result = subject.toJson()
            expect(result).to(equal("{\"thoughts\":\"some thoughts\"}"))
        }
    }
}
