import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

type FeatureItem = {
  title: string;
  Svg: React.ComponentType<React.ComponentProps<'svg'>>;
  description: JSX.Element;
};

// icons from https://www.svgrepo.com/collection/small-flat-vectors/,
// released under Public Domain
const FeatureList: FeatureItem[] = [
  {
    title: 'Customizable Maps',
    Svg: require('@site/static/img/map-map-marker-svgrepo-com.svg').default,
    description: (
      <>
        maplibre supports the highly customizable
        Mapbox Vector Tiles (mvt) standard. You can either use an existing style
        or create your own custom map style.
      </>
    ),
  },
  {
    title: 'High Performance',
    Svg: require('@site/static/img/dashboard-svgrepo-com.svg').default,
    description: (
      <>
        Reliable and fast, maplibre is built on top of the MapLibre GL JS
        for Web and MapLibre Native for other platforms to achieve native speed.
      </>
    ),
  },
  {
    title: 'Open-Source and Vendor-Free',
    Svg: require('@site/static/img/star-svgrepo-com.svg').default,
    description: (
      <>
        MapLibre provides a collection of open-source projects that have no
        vendor lock-in. You can freely choose your map data provider or host
        your own tiles.
      </>
    ),
  },
];

function Feature({title, Svg, description}: FeatureItem) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img"/>
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures(): JSX.Element {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
