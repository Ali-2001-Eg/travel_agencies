part of '../../auth.dart';

class UserAvatarIcon extends StatelessWidget {
  const UserAvatarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF00BFA5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}
