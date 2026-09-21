import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class AdminUsersPanel extends StatelessWidget {
  const AdminUsersPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0x940C0627),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: theme.customColor3.withValues(alpha: 0.35)),
        ),
        child: StreamBuilder<List<UsersRecord>>(
          stream: queryUsersRecord(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                ),
              );
            }

            final users = List<UsersRecord>.from(snapshot.data!)
              ..sort((a, b) {
                final at = a.createdTime;
                final bt = b.createdTime;
                if (at == null && bt == null) {
                  return (a.displayName).compareTo(b.displayName);
                }
                if (at == null) {
                  return 1;
                }
                if (bt == null) {
                  return -1;
                }
                return bt.compareTo(at);
              });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Пользователи',
                        style: theme.titleMedium.override(
                          fontFamily: 'JOST',
                          color: theme.secondaryBackground,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        users.isEmpty
                            ? 'Пока никого нет'
                            : '${users.length} в базе',
                        style: theme.bodySmall.override(
                          fontFamily: 'JOST',
                          color: theme.secondaryBackground
                              .withValues(alpha: 0.7),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: users.isEmpty
                      ? Center(
                          child: Text(
                            'Пользователи не найдены',
                            style: theme.bodyMedium.override(
                              fontFamily: 'JOST',
                              color: theme.secondaryBackground,
                              letterSpacing: 0.0,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                          itemCount: users.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10.0),
                          itemBuilder: (context, index) =>
                              _AdminUserCard(user: users[index]),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AdminUserCard extends StatelessWidget {
  const _AdminUserCard({required this.user});

  final UsersRecord user;

  String get _name {
    final name = user.displayName.trim();
    if (name.isNotEmpty) {
      return name;
    }
    final email = user.email.trim();
    if (email.isNotEmpty) {
      return email.split('@').first;
    }
    return 'Без имени';
  }

  String get _initials {
    final parts = _name.split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) {
      return '?';
    }
    final letters = parts.take(2).map((p) => p[0].toUpperCase());
    return letters.join();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isAdmin = user.adminFalse;
    final email = user.email.trim();
    final photo = user.photoUrl.trim();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.customColor5,
            theme.customColor4.withValues(alpha: 0.94),
          ],
          begin: const AlignmentDirectional(-1.0, 1.0),
          end: const AlignmentDirectional(1.0, -1.0),
        ),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: isAdmin
              ? const Color(0xFFFFE183).withValues(alpha: 0.55)
              : theme.customColor3.withValues(alpha: 0.45),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.0,
              backgroundColor: theme.customColor3,
              backgroundImage: photo.isNotEmpty ? NetworkImage(photo) : null,
              child: photo.isEmpty
                  ? Text(
                      _initials,
                      style: theme.bodyMedium.override(
                        fontFamily: 'JOST',
                        color: theme.secondaryBackground,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.0,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.titleSmall.override(
                            fontFamily: 'JOST',
                            color: theme.secondaryBackground,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (isAdmin)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 3.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFFFE183).withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            'admin',
                            style: theme.bodySmall.override(
                              fontFamily: 'JOST',
                              color: const Color(0xFFFFE183),
                              fontSize: 11.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (email.isNotEmpty) ...[
                    const SizedBox(height: 3.0),
                    Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.bodySmall.override(
                        fontFamily: 'JOST',
                        color:
                            theme.secondaryBackground.withValues(alpha: 0.65),
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
