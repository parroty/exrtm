Code.require_file "../test_helper.exs", __DIR__

defmodule Exrtm.XmlTest do
  use ExUnit.Case
  alias Exrtm.Xml.XmlNode

  setup do
    doc = XmlNode.from_string(%b(
      <root>
        <child id="1">NodeA</child>
        <child id="2">NodeB</child>
      </root>
    ))
    { :ok, doc: doc }
  end

  test "to return first element", meta do
    assert(meta[:doc] |> XmlNode.first("//child[@id='1']") |> XmlNode.text == "NodeA")
  end

  test "to return second element", meta do
    assert(meta[:doc] |> XmlNode.first("//child[@id='2']") |> XmlNode.text == "NodeB")
  end

  test "to return nonexistent element", meta do
    assert(meta[:doc] |> XmlNode.first("//child[@id='3']") |> XmlNode.text == nil)
  end

  test "to return element when selector is applied twice", meta do
    assert(meta[:doc] |> XmlNode.first("//root") |> XmlNode.first("//child[@id='1']") |> XmlNode.text == "NodeA")
  end

  test "to acquire id attribute", meta do
    assert(meta[:doc] |> XmlNode.first("//child")|> XmlNode.attr("id") == "1")
  end
end
