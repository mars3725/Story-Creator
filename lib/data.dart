class Story {
  int id;
  String title, idea, experience;
}

class Setting {
  int id;
  String when, where, what, why;
}

class Protagonist {
  int id;
  String who, actualStrength, actualStrengthReason, perceivedStrength, perceivedStrengthReason, innerConflict, innerConflictReason, establishedNorm, goal, distinctiveness;
}

class Deuteragonist {
  int id;
  String who, actualStrength, actualStrengthReason, perceivedStrength, perceivedStrengthReason, innerConflict, innerConflictReason, establishedNorm, goal, significance, similarity;
}

class Antagonist {
  int id;
  String who, actualStrength, actualStrengthReason, perceivedStrength, perceivedStrengthReason, innerConflict, innerConflictReason, establishedNorm, goal, significance, similarity, distinctiveness;
}

class Plot {
  int id;
  String hero, heroReason, villain, villainReason, stakes;
}

class Beginning {
  int id;
  String resolution, setting, characters, goal, incitingIncident;
}

class Middle {
  int id;
  String action, actionReason, reaction, climax;
}

class End {
  int id;
  String action, consequence, resolution;
}

class StoryArc {
  int id;
  String setting,
      establishedNorm,
      incitingIncident,
      incitingIncidentReason,
      stakes,
      risingAction,
      risingActionReason,
      risingReaction,
      climax,
      fallingAction,
      fallingActionReason,
      resolution,
      resolutionReason,
      babyArcBeginning,
      babyArcMiddle,
      babyArcEnd,
      synopsis,
      logLine,
      tagLine,
      themes;
}

class Character {
  int id, age, height;
  String name,
      sex,
      bodyType,
      nationality,
      birthPlace,
      raised,
      languages,
      family,
      childhoodSocioeconomic,
      education,
      residence,
      profession,
      currentSocioeconomic,
      romantic,
      sexualOrientation,
      attraction,
      significantOther,
      skills,
      hobbies,
      lifeGoal,
      personalityType,
      intelligence,
      spirituality,
      emotionality,
      coreValues,
      socialValues,
      perceivedStrength,
      actualStrength,
      perceivedWeakness,
      actualWeakness,
      innerConflict,
      alignment,
      backstory,
      notes;
}

class World {
  int id;
  String name, country, state, capital, resources, majorLocations, majorLocationResources, climate, terrain, wildlife, flora, magic, technology;
}

class Device {
  int id;
  String name,
      basedOn,
      what,
      energy,
      channel,
      trigger,
      result,
      limit,
      consequences,
      types,
      beginning,
      history,
      who,
      why,
      whoKnows,
      whyKnows,
      culture,
      governance,
      worldCalled,
      base,
      comesFrom,
      practitionersName,
      qualifications,
      applications,
      variations,
      rules,
      punishment,
      timeline,
      awareness,
      reason,
      life,
      rulingBody;
}
