//
//  AppConfigRepository.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation

protocol AppConfigRepository {
    /// 앱 설정을 초기화하는 메서드.
    func initializeAppConfig()
    
    /// 포커스 시간 단위를 설정하는 메서드.
    /// - Parameters:
    ///   - pomoTimer: 변경할 포모 타이머 객체
    ///   - time: 설정할 시간 값
    func setFocusTimeUnit(pomoTimer: PomoTimer, time: TimeInterval)
    
    /// 사이클당 토마토 개수를 설정하는 메서드.
    /// - Parameters:
    ///   - pomoTimer: 변경할 포모 타이머 객체
    ///   - tomato: 설정할 토마토 개수
    func setTomatoPerCycle(pomoTimer: PomoTimer, tomato: Int)
    
    /// 짧은 휴식 시간을 설정하는 메서드.
    /// - Parameters:
    ///   - pomoTimer: 변경할 포모 타이머 객체
    ///   - time: 설정할 시간 값
    func setShortBreakUnit(pomoTimer: PomoTimer, time: TimeInterval)
    
    /// 긴 휴식 시간을 설정하는 메서드.
    /// - Parameters:
    ///   - pomoTimer: 변경할 포모 타이머 객체
    ///   - time: 설정할 시간 값
    func setLongBreakUnit(pomoTimer: PomoTimer, time: TimeInterval)
    
    /// 태그 목록을 업데이트하는 메서드.
    /// - Parameter tags: 업데이트할 태그 배열
    func setTags(_ tags: [Tag])
    
    /// 앱 설정 데이터를 가져오는 메서드.
    /// - Returns: `AppConfigDTO` 데이터를 포함하는 `Result` 타입
    func getAppConfig() -> Result<AppConfigDTO, SwiftDataError>
}
