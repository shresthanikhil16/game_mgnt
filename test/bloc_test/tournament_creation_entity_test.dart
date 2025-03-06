import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/tournament_creation/domain/entity/tournament_creation_entity.dart';
import 'package:game_mgnt/features/tournament_creation/domain/repository/tournament_creation_repository.dart';
import 'package:game_mgnt/features/tournament_creation/domain/use_case/tournament_creation_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for ITournamentRepository
class MockTournamentRepository extends Mock implements ITournamentRepository {}

void main() {
  late CreateTournamentUseCase createTournamentUseCase;
  late GetTournamentsByGameUseCase getTournamentsByGameUseCase;
  late GetTournamentNamesByGameUseCase getTournamentNamesByGameUseCase;
  late MockTournamentRepository mockRepository;

  setUp(() {
    mockRepository = MockTournamentRepository();
    createTournamentUseCase = CreateTournamentUseCase(mockRepository);
    getTournamentsByGameUseCase = GetTournamentsByGameUseCase(mockRepository);
    getTournamentNamesByGameUseCase =
        GetTournamentNamesByGameUseCase(mockRepository);
  });

  final tournament = TournamentEntity(
    name: 'Champions Cup',
    game: 'FIFA 24',
    startDate: DateTime(2024, 3, 10),
    endDate: DateTime(2024, 3, 20),
    prize: '\$10,000',
    description: 'An elite tournament for top players.',
  );

  final tournamentList = [
    tournament,
    TournamentEntity(
      name: 'Battle Royale',
      game: 'FIFA 24',
      startDate: DateTime(2024, 4, 5),
      endDate: DateTime(2024, 4, 15),
      prize: '\$5,000',
      description: 'A knockout tournament with intense matches.',
    ),
  ];

  final tournamentNames = ['Champions Cup', 'Battle Royale'];

  group('CreateTournamentUseCase', () {
    test('should return void when tournament is successfully created',
        () async {
      // Arrange
      when(() => mockRepository.createTournament(tournament))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await createTournamentUseCase.execute(tournament);

      // Assert
      expect(result, const Right(null));
      verify(() => mockRepository.createTournament(tournament)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when tournament creation fails', () async {
      // Arrange
      final failure = ApiFailure(message: ' Failed to fetch tournament names');
      when(() => mockRepository.createTournament(tournament))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await createTournamentUseCase.execute(tournament);

      // Assert
      expect(result, Left(failure));
      verify(() => mockRepository.createTournament(tournament)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });

  group('GetTournamentsByGameUseCase', () {
    test('should return list of tournaments when call is successful', () async {
      // Arrange
      when(() => mockRepository.getTournamentsByGame('FIFA 24'))
          .thenAnswer((_) async => Right(tournamentList));

      // Act
      final result = await getTournamentsByGameUseCase.execute('FIFA 24');

      // Assert
      expect(result, Right(tournamentList));
      verify(() => mockRepository.getTournamentsByGame('FIFA 24')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when fetching tournaments fails', () async {
      // Arrange
      final failure = ApiFailure(message: ' Failed to fetch tournament names');
      when(() => mockRepository.getTournamentsByGame('FIFA 24'))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await getTournamentsByGameUseCase.execute('FIFA 24');

      // Assert
      expect(result, Left(failure));
      verify(() => mockRepository.getTournamentsByGame('FIFA 24')).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });

  group('GetTournamentNamesByGameUseCase', () {
    test('should return list of tournament names when call is successful',
        () async {
      // Arrange
      when(() => mockRepository.getTournamentNamesByGame('FIFA 24'))
          .thenAnswer((_) async => Right(tournamentNames));

      // Act
      final result = await getTournamentNamesByGameUseCase.execute('FIFA 24');

      // Assert
      expect(result, Right(tournamentNames));
      verify(() => mockRepository.getTournamentNamesByGame('FIFA 24'))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when fetching tournament names fails',
        () async {
      // Arrange
      final failure = ApiFailure(message: ' Failed to fetch tournament names');
      when(() => mockRepository.getTournamentNamesByGame('FIFA 24'))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await getTournamentNamesByGameUseCase.execute('FIFA 24');

      // Assert
      expect(result, Left(failure));
      verify(() => mockRepository.getTournamentNamesByGame('FIFA 24'))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
