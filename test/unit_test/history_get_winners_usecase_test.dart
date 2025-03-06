import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_mgnt/core/error/failure.dart';
import 'package:game_mgnt/features/history/domain/entity/history_entity.dart';
import 'package:game_mgnt/features/history/domain/repository/history_repository.dart';
import 'package:game_mgnt/features/history/domain/use_case/history_get_winners_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for HistoryRepository
class MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  late GetWinnersUseCase useCase;
  late MockHistoryRepository mockRepository;

  setUp(() {
    mockRepository = MockHistoryRepository();
    useCase = GetWinnersUseCase(repository: mockRepository);
  });

  final testWinners = [
    HistoryEntity(
      tournament: 'Tournament 1',
      winner: 'Player1',
      date: DateTime(2024, 3, 5),
    ),
    HistoryEntity(
      tournament: 'Tournament 2',
      winner: 'Player2',
      date: DateTime(2024, 3, 4),
    ),
  ];

  test(
      'should return a list of HistoryEntity when repository call is successful',
      () async {
    // Arrange
    when(() => mockRepository.getWinners())
        .thenAnswer((_) async => Right(testWinners));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, Right(testWinners));
    verify(() => mockRepository.getWinners()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a Failure when repository call fails', () async {
    // Arrange
    final failure = ApiFailure(message: 'Failed to get winners');
    when(() => mockRepository.getWinners())
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getWinners()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
