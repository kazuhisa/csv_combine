require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CsvCombine" do
  before do
    @file_a = "./spec/files/a.csv"
    @file_b = "./spec/files/b.csv"
  end
  it "The item acquires correctly." do
    reader = CsvCombine.open(@file_a, @file_b)
    output = reader.to_a
    output.size.should == 8
    output[0].should == ["name","age","instrument"]
    output[1].should == ["Yui Hirasawa","17","guitar"]
    output[2].should == ["Mio Akiyama","17","base"]
    output[3].should == ["Ritsu Tainaka","17","dram"]
    output[4].should == ["Tsumugi Kotobuki","17","keyboard"]
    output[5].should == ["name","age","instrument"]
    output[6].should == ["Azusa Nakano","16","guitar"]
    output[7].should == ["Mio Akiyama","17","base"]
  end

  it "The skip option of a header should be operating correctly." do
    reader = CsvCombine.open(@file_a, @file_b,:skip_header_files => @file_b)
    output = reader.to_a
    output.size.should == 7
    output[0].should == ["name","age","instrument"]
    output[1].should == ["Yui Hirasawa","17","guitar"]
    output[2].should == ["Mio Akiyama","17","base"]
    output[3].should == ["Ritsu Tainaka","17","dram"]
    output[4].should == ["Tsumugi Kotobuki","17","keyboard"]
    output[5].should == ["Azusa Nakano","16","guitar"]
    output[6].should == ["Mio Akiyama","17","base"]
  end

  it "The uniq option should be operating correctly." do
    reader = CsvCombine.open(@file_a, @file_b,:uniq => true)
    output = reader.to_a
    output.size.should == 6
    output[0].should == ["name","age","instrument"]
    output[1].should == ["Yui Hirasawa","17","guitar"]
    output[2].should == ["Mio Akiyama","17","base"]
    output[3].should == ["Ritsu Tainaka","17","dram"]
    output[4].should == ["Tsumugi Kotobuki","17","keyboard"]
    output[5].should == ["Azusa Nakano","16","guitar"]
  end
end
