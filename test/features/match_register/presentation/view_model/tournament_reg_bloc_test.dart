import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/match_register/domain/entity/tournament_registration_entity.dart';
import 'package:game_mgnt/features/match_register/domain/use_case/usecase.dart';
import 'package:game_mgnt/features/match_register/presentation/view_model/tournament_reg_bloc.dart';
import 'package:game_mgnt/features/match_register/presentation/view_model/tournament_reg_event.dart';
import 'package:game_mgnt/features/match_register/presentation/view_model/tournament_reg_state.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterPlayerUseCase extends Mock implements RegisterPlayerUseCase {}

class MockGetRegisteredPlayersUseCase extends Mock
    implements GetRegisteredPlayersUseCase {}

class MockGetTournamentNamesUseCase extends Mock
    implements GetTournamentNamesUseCase {}

class MockGetAllGameNamesUseCase extends Mock
    implements GetAllGameNamesUseCase {}

void main() {
  late TournamentRegistrationBloc bloc;
  late MockRegisterPlayerUseCase mockRegisterPlayerUseCase;
  late MockGetRegisteredPlayersUseCase mockGetRegisteredPlayersUseCase;
  late MockGetTournamentNamesUseCase mockGetTournamentNamesUseCase;
  late MockGetAllGameNamesUseCase mockGetAllGameNamesUseCase;

  setUp(() {
    mockRegisterPlayerUseCase = MockRegisterPlayerUseCase();
    mockGetRegisteredPlayersUseCase = MockGetRegisteredPlayersUseCase();
    mockGetTournamentNamesUseCase = MockGetTournamentNamesUseCase();
    mockGetAllGameNamesUseCase = MockGetAllGameNamesUseCase();

    bloc = TournamentRegistrationBloc(
      registerPlayerUseCase: mockRegisterPlayerUseCase,
      getRegisteredPlayersUseCase: mockGetRegisteredPlayersUseCase,
      getTournamentNamesUseCase: mockGetTournamentNamesUseCase,
      getAllGameNamesUseCase: mockGetAllGameNamesUseCase,
    );
  });

  group('TournamentRegistrationBloc', () {
    const testPlayer = TournamentRegistrationEntity(
      name: 'John Doe',
      email: 'john@example.com',
      game: 'Game 1',
      tournament: 'Tournament A',
      teamNumber: '3',
    );

    const testTournamentNames = ['Tournament A', 'Tournament B'];
    const testGameNames = ['Game 1', 'Game 2'];

    test('initial state should be TournamentRegistrationInitial', () {
      expect(bloc.state, TournamentRegistrationInitial());
    });

    blocTest<TournamentRegistrationBloc, TournamentRegistrationState>(
      'emits [TournamentRegistrationLoading, TournamentRegistrationSuccess] when RegisterPlayer succeeds',
      build: () {
        when(() => mockRegisterPlayerUseCase.execute(testPlayer))
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(RegisterPlayer(testPlayer)),
      expect: () => [
        TournamentRegistrationLoading(),
        TournamentRegistrationSuccess(),
      ],
      verify: (_) {
        verify(() => mockRegisterPlayerUseCase.execute(testPlayer)).called(1);
      },
    );

    blocTest<TournamentRegistrationBloc, TournamentRegistrationState>(
      'emits [TournamentRegistrationLoading, TournamentRegistrationError] when RegisterPlayer fails',
      build: () {
        when(() => mockRegisterPlayerUseCase.execute(testPlayer)).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Failed to register')));
        return bloc;
      },
      act: (bloc) => bloc.add(RegisterPlayer(testPlayer)),
      expect: () => [
        TournamentRegistrationLoading(),
        TournamentRegistrationError('Failed to register'),
      ],
    );

    blocTest<TournamentRegistrationBloc, TournamentRegistrationState>(
      'emits [TournamentRegistrationLoading, RegisteredPlayersLoaded] when FetchRegisteredPlayers succeeds',
      build: () {
        when(() => mockGetRegisteredPlayersUseCase.execute())
            .thenAnswer((_) async => const Right([testPlayer]));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchRegisteredPlayers()),
      expect: () => [
        TournamentRegistrationLoading(),
        RegisteredPlayersLoaded([testPlayer]),
      ],
    );

    blocTest<TournamentRegistrationBloc, TournamentRegistrationState>(
      'emits [TournamentRegistrationLoading, TournamentRegistrationError] when FetchRegisteredPlayers fails',
      build: () {
        when(() => mockGetRegisteredPlayersUseCase.execute()).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Failed to load players')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchRegisteredPlayers()),
      expect: () => [
        TournamentRegistrationLoading(),
        TournamentRegistrationError('Failed to load players'),
      ],
    );

    blocTest<TournamentRegistrationBloc, TournamentRegistrationState>(
      'emits [TournamentRegistrationLoading, TournamentNamesLoaded] when FetchTournamentNames succeeds',
      build: () {
        when(() => mockGetTournamentNamesUseCase.execute('Game 1'))
            .thenAnswer((_) async => const Right(testTournamentNames));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTournamentNames('Game 1')),
      expect: () => [
        TournamentRegistrationLoading(),
        TournamentNamesLoaded(testTournamentNames),
      ],
    );

    blocTest<TournamentRegistrationBloc, TournamentRegistrationState>(
      'emits [TournamentRegistrationLoading, TournamentRegistrationError] when FetchTournamentNames fails',
      build: () {
        when(() => mockGetTournamentNamesUseCase.execute('Game 1')).thenAnswer(
            (_) async =>
                Left(ApiFailure(message: 'Failed to load tournaments')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTournamentNames('Game 1')),
      expect: () => [
        TournamentRegistrationLoading(),
        TournamentRegistrationError('Failed to load tournaments'),
      ],
    );

    blocTest<TournamentRegistrationBloc, TournamentRegistrationState>(
      'emits [TournamentRegistrationLoading, AllGameNamesLoaded] when FetchAllGameNames succeeds',
      build: () {
        when(() => mockGetAllGameNamesUseCase.execute())
            .thenAnswer((_) async => const Right(testGameNames));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchAllGameNames()),
      expect: () => [
        TournamentRegistrationLoading(),
        AllGameNamesLoaded(testGameNames),
      ],
    );

    blocTest<TournamentRegistrationBloc, TournamentRegistrationState>(
      'emits [TournamentRegistrationLoading, TournamentRegistrationError] when FetchAllGameNames fails',
      build: () {
        when(() => mockGetAllGameNamesUseCase.execute()).thenAnswer(
            (_) async => Left(ApiFailure(message: 'Failed to load games')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchAllGameNames()),
      expect: () => [
        TournamentRegistrationLoading(),
        TournamentRegistrationError('Failed to load games'),
      ],
    );
  });
}
