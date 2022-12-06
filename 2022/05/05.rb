class StackSimulation
  def initialize(input, model)
    (stacks, instructions) = parse(input)
    @input_stacks = stacks.split("\n").reject(&:empty?)
    @input_instructions = instructions.split("\n").reject(&:empty?)
    @model = model
  end

  def process
    create_stacks
    run_instructions
    calculate_top_boxes
  end

  private

  def parse(str)
    str.split("\n\n")
  end

  def create_stacks
    @stacks = @input_stacks.reverse.map.with_index do |stack, index|
      boxes = stack.scan(/\[(\w+)\]|   /)
      boxes.map.with_index do |box, column|
        { level: index, value: box[0], column: column + 1 }
      end.reject(&:nil?)
    end.reject(&:nil?).flatten
  end

  def run_instructions
    @input_instructions.each do |instruction|
      parts = instruction.match(/move (\d+) from (\d+) to (\d+)/)

      from_stack = @stacks.select { |stack| stack[:column] == parts[2].to_i && !stack[:value].nil? }
      to_stack_top = @stacks.select { |stack| stack[:column] == parts[3].to_i && !stack[:value].nil? }.last

      @stacks -= from_stack

      processed = (1..parts[1].to_i).map do
        box = from_stack.pop
        box[:column] = parts[3].to_i
        box
      end

      processed.reverse! if @model == 'CrateMover 9001'

      processed.each_with_index do |box, i|
        box[:level] = to_stack_top.nil? ? i + 1 : to_stack_top[:level] + i + 1
      end

      @stacks = @stacks + from_stack + processed
    end
  end

  def calculate_top_boxes
    @stacks.group_by { |stack| stack[:column] }.map do |_k, v|
      v.last[:value]
    end.join('')
  end
end

input = File.read(File.join(__dir__, 'input.txt'))
stack = StackSimulation.new(input, 'CrateMover 9000')
stack2 = StackSimulation.new(input, 'CrateMover 9001')

puts stack.process
puts stack2.process
