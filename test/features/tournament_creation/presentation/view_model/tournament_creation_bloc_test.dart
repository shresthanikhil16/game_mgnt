import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/tournament_creation/data/repository/tournament_creation_remote_repository.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view_model/tournament_creation_bloc.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view_model/tournament_creation_event.dart';
import 'package:game_mgnt/features/tournament_creation/presentation/view_model/tournament_creation_state.dart';
import 'package:mocktail/mocktail.dart';

class MockTournamentRepository extends Mock implements TournamentRepository {}

void main() {
  late TournamentBloc tournamentBloc;
  late MockTournamentRepository mockRepository;

  setUp(() {
    mockRepository = MockTournamentRepository();
    tournamentBloc = TournamentBloc(mockRepository);
  });

  tearDown(() {
    tournamentBloc.close();
  });

  final testTournament = TournamentEntity(
    name: "Championship",
    game: "FIFA 24",
    startDate: DateTime(2025, 6, 1),
    endDate: DateTime(2025, 6, 15),
    prize: "10000",
    description: "Best tournament ever",
  );

  group('TournamentBloc Tests', () {
    blocTest<TournamentBloc, TournamentState>(
      'emits [TournamentLoading, TournamentSuccess] when CreateTournament is successful',
      build: () => tournamentBloc,
      act: (bloc) async {
        bloc.add(CreateTournament(testTournament));
        await Future.delayed(
            Duration.zero); // Ensures async operations are processed
      },
      expect: () => [
        TournamentLoading(),
        const TournamentSuccess("Tournament created successfully"),
      ],
      verify: (_) {
        verify(() => mockRepository.createTournament(testTournament)).called(1);
      },
    );

    blocTest<TournamentBloc, TournamentState>(
      'emits [TournamentLoading, TournamentError] when CreateTournament fails',
      build: () {
        when(() => mockRepository.createTournament(testTournament)).thenAnswer(
            (_) async =>
                Left(ApiFailure(message: "Failed to create tournament")));
        return tournamentBloc;
      },
      act: (bloc) => bloc.add(CreateTournament(testTournament)),
      expect: () => [
        TournamentLoading(),
        TournamentError("Failed to create tournament"),
      ],
      verify: (_) {
        verify(() => mockRepository.createTournament(testTournament)).called(1);
      },
    );

    blocTest<TournamentBloc, TournamentState>(
      'emits [TournamentLoading, TournamentLoaded] when FetchTournaments succeeds',
      build: () {
        when(() => mockRepository.getTournamentsByGame("FIFA 24"))
            .thenAnswer((_) async => Right([testTournament]));
        return tournamentBloc;
      },
      act: (bloc) => bloc.add(FetchTournaments("FIFA 24")),
      expect: () => [
        TournamentLoading(),
        TournamentLoaded([testTournament]),
      ],
      verify: (_) {
        verify(() => mockRepository.getTournamentsByGame("FIFA 24")).called(1);
      },
    );

    blocTest<TournamentBloc, TournamentState>(
      'emits [TournamentLoading, TournamentError] when FetchTournaments fails',
      build: () {
        when(() => mockRepository.getTournamentsByGame("FIFA 24")).thenAnswer(
            (_) async =>
                Left(ApiFailure(message: "Failed to fetch tournaments")));
        return tournamentBloc;
      },
      act: (bloc) => bloc.add(FetchTournaments("FIFA 24")),
      expect: () => [
        TournamentLoading(),
        TournamentError("Failed to fetch tournaments"),
      ],
      verify: (_) {
        verify(() => mockRepository.getTournamentsByGame("FIFA 24")).called(1);
      },
    );

    blocTest<TournamentBloc, TournamentState>(
      'emits [TournamentLoading, TournamentNamesLoaded] when FetchTournamentNames succeeds',
      build: () {
        when(() => mockRepository.getTournamentNamesByGame("FIFA 24"))
            .thenAnswer((_) async => Right(["Championship", "World Cup"]));
        return tournamentBloc;
      },
      act: (bloc) => bloc.add(FetchTournamentNames("FIFA 24")),
      expect: () => [
        TournamentLoading(),
        TournamentNamesLoaded(["Championship", "World Cup"]),
      ],
      verify: (_) {
        verify(() => mockRepository.getTournamentNamesByGame("FIFA 24"))
            .called(1);
      },
    );

    blocTest<TournamentBloc, TournamentState>(
      'emits [TournamentLoading, TournamentError] when FetchTournamentNames fails',
      build: () {
        when(() => mockRepository.getTournamentNamesByGame("FIFA 24"))
            .thenAnswer((_) async =>
                Left(ApiFailure(message: "Failed to fetch names")));
        return tournamentBloc;
      },
      act: (bloc) => bloc.add(FetchTournamentNames("FIFA 24")),
      expect: () => [
        TournamentLoading(),
        TournamentError("Failed to fetch names"),
      ],
      verify: (_) {
        verify(() => mockRepository.getTournamentNamesByGame("FIFA 24"))
            .called(1);
      },
    );

    blocTest<TournamentBloc, TournamentState>(
      'emits [TournamentLoading, GameListLoaded] when FetchGameList succeeds',
      build: () {
        when(() => mockRepository.getGameList())
            .thenAnswer((_) async => Right(["FIFA 24", "Valorant", "COD"]));
        return tournamentBloc;
      },
      act: (bloc) => bloc.add(FetchGameList()),
      expect: () => [
        TournamentLoading(),
        GameListLoaded(["FIFA 24", "Valorant", "COD"]),
      ],
      verify: (_) {
        verify(() => mockRepository.getGameList()).called(1);
      },
    );

    blocTest<TournamentBloc, TournamentState>(
      'emits [TournamentLoading, TournamentError] when FetchGameList fails',
      build: () {
        when(() => mockRepository.getGameList()).thenAnswer(
            (_) async => Left(ApiFailure(message: "Failed to fetch games")));
        return tournamentBloc;
      },
      act: (bloc) => bloc.add(FetchGameList()),
      expect: () => [
        TournamentLoading(),
        TournamentError("Failed to fetch games"),
      ],
      verify: (_) {
        verify(() => mockRepository.getGameList()).called(1);
      },
    );
  });
}
