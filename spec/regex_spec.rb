require 'myregex'
describe MyRegex do
  subject      { reggy.match? input }
  let (:body)  { 'a' }
  let (:reggy) { MyRegex::build body }


  context "Parsing a" do
    context "Literal match" do

      let (:body) { 'abc' }

      context '/abc/ applied to "abc"' do
        let (:input) { "abc" }

        it "matches" do
          should eq(true)
        end
      end

      context '/abc/ applied to "abcd"' do
        let (:input) { 'abcd' }

        it "matches" do
          should eq(true)
        end
      end

    end

    context 'single wild card match' do
      let (:body) { "ab." }
      context '/ab./ applied to "abc"' do
        let (:input) { 'abc' }
        it 'matches' do
          should eq(true)
        end
      end

      context
    end
    context 'applied to a target that does match the expression' do

      it "does match" do
        expect(reggy.match? "a").to eq(true)
      end

    end
  end

end
