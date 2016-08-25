module CommandMacro
  def one_off_cmd(editor, input)
    allow(editor).to receive(:gets) do
      subject.instance_variable_set(:@running, false)
      input
    end
  end

  def cmd(editor, input)
    allow(editor).to receive(:gets) { input }
  end
end
