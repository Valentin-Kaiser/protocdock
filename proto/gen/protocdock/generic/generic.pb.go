// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.36.6
// 	protoc        v6.30.2
// source: generic.proto

package generic

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
	unsafe "unsafe"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type Empty struct {
	state         protoimpl.MessageState `protogen:"open.v1"`
	unknownFields protoimpl.UnknownFields
	sizeCache     protoimpl.SizeCache
}

func (x *Empty) Reset() {
	*x = Empty{}
	mi := &file_generic_proto_msgTypes[0]
	ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
	ms.StoreMessageInfo(mi)
}

func (x *Empty) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*Empty) ProtoMessage() {}

func (x *Empty) ProtoReflect() protoreflect.Message {
	mi := &file_generic_proto_msgTypes[0]
	if x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use Empty.ProtoReflect.Descriptor instead.
func (*Empty) Descriptor() ([]byte, []int) {
	return file_generic_proto_rawDescGZIP(), []int{0}
}

var File_generic_proto protoreflect.FileDescriptor

const file_generic_proto_rawDesc = "" +
	"\n" +
	"\rgeneric.proto\x12\ageneric\"\a\n" +
	"\x05EmptyB\x14Z\x12protocdock/genericb\x06proto3"

var (
	file_generic_proto_rawDescOnce sync.Once
	file_generic_proto_rawDescData []byte
)

func file_generic_proto_rawDescGZIP() []byte {
	file_generic_proto_rawDescOnce.Do(func() {
		file_generic_proto_rawDescData = protoimpl.X.CompressGZIP(unsafe.Slice(unsafe.StringData(file_generic_proto_rawDesc), len(file_generic_proto_rawDesc)))
	})
	return file_generic_proto_rawDescData
}

var file_generic_proto_msgTypes = make([]protoimpl.MessageInfo, 1)
var file_generic_proto_goTypes = []any{
	(*Empty)(nil), // 0: generic.Empty
}
var file_generic_proto_depIdxs = []int32{
	0, // [0:0] is the sub-list for method output_type
	0, // [0:0] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_generic_proto_init() }
func file_generic_proto_init() {
	if File_generic_proto != nil {
		return
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: unsafe.Slice(unsafe.StringData(file_generic_proto_rawDesc), len(file_generic_proto_rawDesc)),
			NumEnums:      0,
			NumMessages:   1,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_generic_proto_goTypes,
		DependencyIndexes: file_generic_proto_depIdxs,
		MessageInfos:      file_generic_proto_msgTypes,
	}.Build()
	File_generic_proto = out.File
	file_generic_proto_goTypes = nil
	file_generic_proto_depIdxs = nil
}
