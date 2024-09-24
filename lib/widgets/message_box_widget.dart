import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  final ValueChanged<String> onSendMessage;

  const MessageBox({super.key, required this.onSendMessage});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          myTextField(
            'Nhập tại đây',
            Colors.blue,
            _controller,
            TextInputType.multiline,
            Icons.send,
            (value) {
              if (value.trim().isNotEmpty) {
                widget.onSendMessage(value);
                _controller.clear();
              } else {
                String text = _controller.text;
                if (text.trim().isNotEmpty) {
                  widget.onSendMessage(text);
                  _controller.clear();
                } else {
                  // Tùy chọn: Hiển thị thông báo lỗi
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vui lòng nhập tin nhắn!')));
                }
              }
            },
            () {
              String text = _controller.text;
              if (text.trim().isNotEmpty) {
                widget.onSendMessage(text);
                _controller.clear();
              } else {
                // Tùy chọn: Hiển thị thông báo lỗi
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vui lòng nhập tin nhắn!')));
              }
            },
          ),
        ],
      ),
    );
  }
}

Container myTextField(
  String hint,
  Color suffixIconColor,
  TextEditingController controller,
  TextInputType type,
  IconData suffixIcon,
  void Function(String) onFieldSubmitted,
  VoidCallback onPress,
) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 10,
    ),
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this field cannot be empty';
        }
        return null;
      },
      keyboardType: type,

      // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(regexp))],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 22,
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black45,
          fontSize: 19,
        ),
        suffixIcon: IconButton(
          onPressed: onPress,
          icon: Icon(suffixIcon),
          color: suffixIconColor,
        ),
      ),
      onFieldSubmitted: onFieldSubmitted,
    ),
  );
}
