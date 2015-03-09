require 'myregex'
describe MyRegex do
  let (:body)  { '/a/' }
  let (:reggy) { MyRegex::build body }

  context "Parsing an expression" do
    context "applied to a target which does not match the expression" do
      it "does not match" do
        expect(reggy.match? "b").to eq(false)
      end
    end
    context 'applied to a target that does match the expression' do
      it "does match" do
        expect(reggy.match? "a").to eq(true)
      end
    end
  end
end
