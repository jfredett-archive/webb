module Webb.Logic.Abstract where

class AbstractLogic a where
  (/\) :: a -> a -> a
  (\/) :: a -> a -> a
  neg  :: a -> a

  -- laws:
  --
  -- neg . neg = id

{-class AbstractLogic a => DemorganLogic a where-}
  -- laws:
  -- x /\ y = neg $ neg x \/ neg y

{-class AbstractLogic a => CommutativeLogic a where-}
  -- laws:
  -- x /\ y = y /\ x
  -- x \/ y = y \/ x

{-instance (AbstractLogic a, DemorganLogic a) => CommutativeLogic a where-}
  -- if x /\ y & Demorgan
  -- x \/ y = (x' /\ y')' = (y' /\ x)' = y \/ x
