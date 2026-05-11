module Text.HTML.Tag

%default total

||| HTML Element Tags linking tag names with an enumeration.
|||
||| Local fork: extends upstream with HTML5 semantic + inline tags missing
||| from the original (Nav, Main, Figure, Mark, Em, Strong, Code, ...).
||| Mark patches with the comment "-- LOCAL ADD" so a future merge with
||| upstream is straightforward.
public export
data HTMLTag : (tag : String) -> Type where
  A          : HTMLTag "a"
  Abbr       : HTMLTag "abbr"            -- LOCAL ADD
  Address    : HTMLTag "address"
  Area       : HTMLTag "area"
  Article    : HTMLTag "article"
  Aside      : HTMLTag "aside"
  Audio      : HTMLTag "audio"
  B          : HTMLTag "b"               -- LOCAL ADD
  Base       : HTMLTag "base"
  Bdi        : HTMLTag "bdi"             -- LOCAL ADD
  Bdo        : HTMLTag "bdo"             -- LOCAL ADD
  Blockquote : HTMLTag "blockquote"
  Body       : HTMLTag "body"
  Br         : HTMLTag "br"
  Button     : HTMLTag "button"
  Canvas     : HTMLTag "canvas"
  Caption    : HTMLTag "caption"
  Cite       : HTMLTag "cite"            -- LOCAL ADD
  Code       : HTMLTag "code"            -- LOCAL ADD
  Col        : HTMLTag "col"
  Colgroup   : HTMLTag "colgroup"
  Data       : HTMLTag "data"
  Datalist   : HTMLTag "datalist"
  Dd         : HTMLTag "dd"              -- LOCAL ADD
  Del        : HTMLTag "del"
  Details    : HTMLTag "details"
  Dfn        : HTMLTag "dfn"             -- LOCAL ADD
  Dialog     : HTMLTag "dialog"
  Div        : HTMLTag "div"
  Dl         : HTMLTag "dl"
  Dt         : HTMLTag "dt"              -- LOCAL ADD
  Em         : HTMLTag "em"              -- LOCAL ADD
  Embed      : HTMLTag "embed"
  FieldSet   : HTMLTag "fieldset"
  Figcaption : HTMLTag "figcaption"      -- LOCAL ADD
  Figure     : HTMLTag "figure"          -- LOCAL ADD
  Footer     : HTMLTag "footer"
  Form       : HTMLTag "form"
  H1         : HTMLTag "h1"
  H2         : HTMLTag "h2"
  H3         : HTMLTag "h3"
  H4         : HTMLTag "h4"
  H5         : HTMLTag "h5"
  H6         : HTMLTag "h6"
  HR         : HTMLTag "hr"
  Header     : HTMLTag "header"
  Hgroup     : HTMLTag "hgroup"          -- LOCAL ADD
  Html       : HTMLTag "html"
  I          : HTMLTag "i"               -- LOCAL ADD
  IFrame     : HTMLTag "iframe"
  Img        : HTMLTag "img"
  Input      : HTMLTag "input"
  Ins        : HTMLTag "ins"
  Kbd        : HTMLTag "kbd"             -- LOCAL ADD
  Label      : HTMLTag "label"
  Legend     : HTMLTag "legend"
  Li         : HTMLTag "li"
  Link       : HTMLTag "link"
  Main       : HTMLTag "main"            -- LOCAL ADD
  Map        : HTMLTag "map"
  Mark       : HTMLTag "mark"            -- LOCAL ADD
  Menu       : HTMLTag "menu"
  Meta       : HTMLTag "meta"
  Meter      : HTMLTag "meter"
  Nav        : HTMLTag "nav"             -- LOCAL ADD
  Object     : HTMLTag "object"
  Ol         : HTMLTag "ol"
  OptGroup   : HTMLTag "optgroup"
  Option     : HTMLTag "option"
  Output     : HTMLTag "output"
  P          : HTMLTag "p"
  Param      : HTMLTag "param"
  Picture    : HTMLTag "picture"
  Pre        : HTMLTag "pre"
  Progress   : HTMLTag "progress"
  Q          : HTMLTag "q"
  Samp       : HTMLTag "samp"            -- LOCAL ADD
  Script     : HTMLTag "script"
  Search     : HTMLTag "search"          -- LOCAL ADD
  Section    : HTMLTag "section"
  Select     : HTMLTag "select"
  Slot       : HTMLTag "slot"
  Small      : HTMLTag "small"           -- LOCAL ADD
  Source     : HTMLTag "source"
  Span       : HTMLTag "span"
  Strong     : HTMLTag "strong"          -- LOCAL ADD
  Style      : HTMLTag "style"
  Sub        : HTMLTag "sub"             -- LOCAL ADD
  Summary    : HTMLTag "summary"         -- LOCAL ADD
  Sup        : HTMLTag "sup"             -- LOCAL ADD
  Svg        : HTMLTag "svg"
  Table      : HTMLTag "table"
  Tbody      : HTMLTag "tbody"
  Td         : HTMLTag "td"
  Template   : HTMLTag "template"
  TextArea   : HTMLTag "textarea"
  Tfoot      : HTMLTag "tfoot"
  Th         : HTMLTag "th"
  Thead      : HTMLTag "thead"
  Time       : HTMLTag "time"
  Title      : HTMLTag "title"
  Tr         : HTMLTag "tr"
  Track      : HTMLTag "track"
  U          : HTMLTag "u"               -- LOCAL ADD
  Ul         : HTMLTag "ul"
  Var        : HTMLTag "var"             -- LOCAL ADD
  Video      : HTMLTag "video"
  Wbr        : HTMLTag "wbr"             -- LOCAL ADD

||| Proof that we can set a custom validity message to
||| a HTML object with this tag.
public export
data ValidityTag : (t : HTMLTag s) -> Type where
  SVButton   : ValidityTag Button
  SVFieldSet : ValidityTag FieldSet
  SVInput    : ValidityTag Input
  SVObject   : ValidityTag Object
  SVOutput   : ValidityTag Output
  SVSelect   : ValidityTag Select
  SVTextArea : ValidityTag TextArea

||| Proof that we can set a string value to
||| a HTML object with this tag.
public export
data ValueTag : (t : HTMLTag s) -> Type where
  VButton   : ValueTag Button
  VData     : ValueTag Data
  VInput    : ValueTag Input
  VOption   : ValueTag Option
  VOutput   : ValueTag Output
  VParam    : ValueTag Param
  VSelect   : ValueTag Select
  VTextArea : ValueTag TextArea
