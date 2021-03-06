--Generated By protoc-gen-lua Do not Edit
local protobuf = require "Framework.Net.Protobuf.protobuf"
local _M = {}

_M.ONEPLAYERCARDS = protobuf.Descriptor();
_M.ONEPLAYERCARDS_SEATID_FIELD = protobuf.FieldDescriptor();
_M.ONEPLAYERCARDS_NNTYPE_FIELD = protobuf.FieldDescriptor();
_M.ONEPLAYERCARDS_XGOLD_FIELD = protobuf.FieldDescriptor();
_M.ONEPLAYERCARDS_CARDS_FIELD = protobuf.FieldDescriptor();
_M.ALLPLAYERSCARDS = protobuf.Descriptor();
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD = protobuf.FieldDescriptor();

_M.ONEPLAYERCARDS_SEATID_FIELD.name = "seatid"
_M.ONEPLAYERCARDS_SEATID_FIELD.full_name = ".OnePlayerCards.seatid"
_M.ONEPLAYERCARDS_SEATID_FIELD.number = 1
_M.ONEPLAYERCARDS_SEATID_FIELD.index = 0
_M.ONEPLAYERCARDS_SEATID_FIELD.label = 2
_M.ONEPLAYERCARDS_SEATID_FIELD.has_default_value = false
_M.ONEPLAYERCARDS_SEATID_FIELD.default_value = 0
_M.ONEPLAYERCARDS_SEATID_FIELD.type = 5
_M.ONEPLAYERCARDS_SEATID_FIELD.cpp_type = 1

_M.ONEPLAYERCARDS_NNTYPE_FIELD.name = "nntype"
_M.ONEPLAYERCARDS_NNTYPE_FIELD.full_name = ".OnePlayerCards.nntype"
_M.ONEPLAYERCARDS_NNTYPE_FIELD.number = 2
_M.ONEPLAYERCARDS_NNTYPE_FIELD.index = 1
_M.ONEPLAYERCARDS_NNTYPE_FIELD.label = 2
_M.ONEPLAYERCARDS_NNTYPE_FIELD.has_default_value = false
_M.ONEPLAYERCARDS_NNTYPE_FIELD.default_value = 0
_M.ONEPLAYERCARDS_NNTYPE_FIELD.type = 5
_M.ONEPLAYERCARDS_NNTYPE_FIELD.cpp_type = 1

_M.ONEPLAYERCARDS_XGOLD_FIELD.name = "xgold"
_M.ONEPLAYERCARDS_XGOLD_FIELD.full_name = ".OnePlayerCards.xgold"
_M.ONEPLAYERCARDS_XGOLD_FIELD.number = 3
_M.ONEPLAYERCARDS_XGOLD_FIELD.index = 2
_M.ONEPLAYERCARDS_XGOLD_FIELD.label = 2
_M.ONEPLAYERCARDS_XGOLD_FIELD.has_default_value = false
_M.ONEPLAYERCARDS_XGOLD_FIELD.default_value = 0
_M.ONEPLAYERCARDS_XGOLD_FIELD.type = 5
_M.ONEPLAYERCARDS_XGOLD_FIELD.cpp_type = 1

_M.ONEPLAYERCARDS_CARDS_FIELD.name = "cards"
_M.ONEPLAYERCARDS_CARDS_FIELD.full_name = ".OnePlayerCards.cards"
_M.ONEPLAYERCARDS_CARDS_FIELD.number = 4
_M.ONEPLAYERCARDS_CARDS_FIELD.index = 3
_M.ONEPLAYERCARDS_CARDS_FIELD.label = 3
_M.ONEPLAYERCARDS_CARDS_FIELD.has_default_value = false
_M.ONEPLAYERCARDS_CARDS_FIELD.default_value = {}
_M.ONEPLAYERCARDS_CARDS_FIELD.type = 5
_M.ONEPLAYERCARDS_CARDS_FIELD.cpp_type = 1

_M.ONEPLAYERCARDS.name = "OnePlayerCards"
_M.ONEPLAYERCARDS.full_name = ".OnePlayerCards"
_M.ONEPLAYERCARDS.nested_types = {}
_M.ONEPLAYERCARDS.enum_types = {}
_M.ONEPLAYERCARDS.fields = {_M.ONEPLAYERCARDS_SEATID_FIELD, _M.ONEPLAYERCARDS_NNTYPE_FIELD, _M.ONEPLAYERCARDS_XGOLD_FIELD, _M.ONEPLAYERCARDS_CARDS_FIELD}
_M.ONEPLAYERCARDS.is_extendable = false
_M.ONEPLAYERCARDS.extensions = {}
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD.name = "oneplayercards"
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD.full_name = ".AllPlayersCards.oneplayercards"
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD.number = 1
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD.index = 0
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD.label = 3
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD.has_default_value = false
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD.default_value = {}
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD.message_type = _M.ONEPLAYERCARDS
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD.type = 11
_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD.cpp_type = 10

_M.ALLPLAYERSCARDS.name = "AllPlayersCards"
_M.ALLPLAYERSCARDS.full_name = ".AllPlayersCards"
_M.ALLPLAYERSCARDS.nested_types = {}
_M.ALLPLAYERSCARDS.enum_types = {}
_M.ALLPLAYERSCARDS.fields = {_M.ALLPLAYERSCARDS_ONEPLAYERCARDS_FIELD}
_M.ALLPLAYERSCARDS.is_extendable = false
_M.ALLPLAYERSCARDS.extensions = {}

_M.AllPlayersCards = protobuf.Message(_M.ALLPLAYERSCARDS)
_M.OnePlayerCards = protobuf.Message(_M.ONEPLAYERCARDS)

return _M