import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flood_mobile/Blocs/filter_torrent_bloc/filter_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/graph_bloc/graph_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/language_bloc/language_bloc.dart';
import 'package:flood_mobile/Blocs/login_screen_bloc/login_screen_bloc.dart';
import 'package:flood_mobile/Blocs/multiple_select_torrent_bloc/multiple_select_torrent_bloc.dart';
import 'package:flood_mobile/Blocs/onboarding_main_page_bloc/on_boarding_page_color_bloc.dart';
import 'package:flood_mobile/Blocs/power_management_bloc/power_management_bloc.dart';
import 'package:flood_mobile/Blocs/sse_bloc/sse_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/torrent_content_screen_bloc/torrent_content_screen_bloc.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/Blocs/user_interface_bloc/user_interface_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static List<BlocProvider> multiBlocProviders = [
    BlocProvider<ClientSettingsBloc>(
      create: (context) => ClientSettingsBloc(),
      lazy: false,
    ),
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
    ),
    BlocProvider<SSEBloc>(
      create: (context) => SSEBloc(),
    ),
    BlocProvider<HomeScreenBloc>(
      create: (context) => HomeScreenBloc(),
    ),
    BlocProvider<UserDetailBloc>(
      create: (context) => UserDetailBloc(),
    ),
    BlocProvider<ApiBloc>(
      create: (context) => ApiBloc(),
    ),
    BlocProvider<LoginScreenBloc>(
      create: (context) => LoginScreenBloc(),
    ),
    BlocProvider<TorrentContentScreenBloc>(
      create: (context) => TorrentContentScreenBloc(),
    ),
    BlocProvider<MultipleSelectTorrentBloc>(
      create: (context) => MultipleSelectTorrentBloc(),
    ),
    BlocProvider<SpeedGraphBloc>(
      create: (context) => SpeedGraphBloc(),
    ),
    BlocProvider<FilterTorrentBloc>(
      create: (context) => FilterTorrentBloc(),
    ),
    BlocProvider<OnBoardingPageColorBloc>(
      create: (context) => OnBoardingPageColorBloc(),
    ),
    BlocProvider<LanguageBloc>(
      create: (context) => LanguageBloc(),
      lazy: false,
    ),
    BlocProvider<UserInterfaceBloc>(
      create: (context) => UserInterfaceBloc(),
    ),
    BlocProvider<PowerManagementBloc>(
      create: (context) => PowerManagementBloc(),
    ),
  ];
}
